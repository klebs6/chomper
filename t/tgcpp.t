#!/usr/bin/env raku

use Test;
use gcpp;

grammar G does CPP14Parser {}

use Grammar::Tracer;
grammar GD does CPP14Parser {}

my @inputs = [
    q:to/END/,
    std::vector<std::string> errors;
    if (util::WriteSettings(m_banlist_json, {{JSON_KEY, BanMapToJson(banSet)}}, errors)) {
        return true;
    }

    for (const auto& err : errors) {
        error("%s", err);
    }
    return false;
    END
    q:to/END/,
    // If the JSON banlist does not exist, then recreate it
    if (!fs::exists(m_banlist_json)) {
        return false;
    }

    std::map<std::string, util::SettingsValue> settings;
    std::vector<std::string> errors;

    if (!util::ReadSettings(m_banlist_json, settings, errors)) {
        for (const auto& err : errors) {
            LogPrintf("Cannot load banlist %s: %s\n", fs::PathToString(m_banlist_json), err);
        }
        return false;
    }

    try {
        BanMapFromJson(settings[JSON_KEY], banSet);
    } catch (const std::runtime_error& e) {
        LogPrintf("Cannot parse banlist %s: %s\n", fs::PathToString(m_banlist_json), e.what());
        return false;
    }

    return true;
    END
    q:to/END/,
    if (m_client_interface) m_client_interface->InitMessage(_("Loading banlist…").translated);

    int64_t n_start = GetTimeMillis();
    if (m_ban_db.Read(m_banned)) {
        SweepBanned(); // sweep out unused entries

        LogPrint(BCLog::NET, "Loaded %d banned node addresses/subnets  %dms\n", m_banned.size(),
                 GetTimeMillis() - n_start);
    } else {
        LogPrintf("Recreating the banlist database\n");
        m_banned = {};
        m_is_dirty = true;
    }

    DumpBanlist();
    END
    q:to/END/,
    SweepBanned(); // clean unused entries (if bantime has expired)

    if (!BannedSetIsDirty()) return;

    int64_t n_start = GetTimeMillis();

    banmap_t banmap;
    GetBanned(banmap);
    if (m_ban_db.Write(banmap)) {
        SetBannedSetDirty(false);
    }

    LogPrint(BCLog::NET, "Flushed %d banned node addresses/subnets to disk  %dms\n", banmap.size(),
             GetTimeMillis() - n_start);
    END
    q:to/END/,
    {
        LOCK(m_cs_banned);
        m_banned.clear();
        m_is_dirty = true;
    }
    DumpBanlist(); //store banlist to disk
    if (m_client_interface) m_client_interface->BannedListChanged();
    END
    q:to/END/,
    auto current_time = GetTime();
    LOCK(m_cs_banned);
    for (const auto& it : m_banned) {
        CSubNet sub_net = it.first;
        CBanEntry ban_entry = it.second;

        if (current_time < ban_entry.nBanUntil && sub_net.Match(net_addr)) {
            return true;
        }
    }
    return false;
    END
    q:to/END/,
    auto current_time = GetTime();
    LOCK(m_cs_banned);
    banmap_t::iterator i = m_banned.find(sub_net);
    if (i != m_banned.end()) {
        CBanEntry ban_entry = (*i).second;
        if (current_time < ban_entry.nBanUntil) {
            return true;
        }
    }
    return false;
    END
    q:to/END/,
    CBanEntry ban_entry(GetTime());

    int64_t normalized_ban_time_offset = ban_time_offset;
    bool normalized_since_unix_epoch = since_unix_epoch;
    if (ban_time_offset <= 0) {
        normalized_ban_time_offset = m_default_ban_time;
        normalized_since_unix_epoch = false;
    }
    ban_entry.nBanUntil = (normalized_since_unix_epoch ? 0 : GetTime()) + normalized_ban_time_offset;

    {
        LOCK(m_cs_banned);
        if (m_banned[sub_net].nBanUntil < ban_entry.nBanUntil) {
            m_banned[sub_net] = ban_entry;
            m_is_dirty = true;
        } else
            return;
    }
    if (m_client_interface) m_client_interface->BannedListChanged();

    //store banlist to disk immediately
    DumpBanlist();
    END
    q:to/END/,
    {
        LOCK(m_cs_banned);
        if (m_banned.erase(sub_net) == 0) return false;
        m_is_dirty = true;
    }
    if (m_client_interface) m_client_interface->BannedListChanged();
    DumpBanlist(); //store banlist to disk immediately
    return true;
    END
    q:to/END/,
    int64_t now = GetTime();
    bool notify_ui = false;
    {
        LOCK(m_cs_banned);
        banmap_t::iterator it = m_banned.begin();
        while (it != m_banned.end()) {
            CSubNet sub_net = (*it).first;
            CBanEntry ban_entry = (*it).second;
            if (!sub_net.IsValid() || now > ban_entry.nBanUntil) {
                m_banned.erase(it++);
                m_is_dirty = true;
                notify_ui = true;
                LogPrint(BCLog::NET, "Removed banned node address/subnet: %s\n", sub_net.ToString());
            } else
                ++it;
        }
    }
    // update UI
    if (notify_ui && m_client_interface) {
        m_client_interface->BannedListChanged();
    }
    END
    q:to/END/,
    LOCK(m_cs_banned);
    // Sweep the banlist so expired bans are not returned
    SweepBanned();
    banmap = m_banned; //create a thread safe copy
    END
    q:to/END/,
    std::string strMessage = tfm::format(fmt, args...);
    SetMiscWarning(Untranslated(strMessage));
    LogPrintf("*** %s\n", strMessage);
    AbortError(_("A fatal internal error occurred, see debug.log for details"));
    StartShutdown();
    END
    q:to/END/,
    CBlockLocator locator;
    if (!GetDB().ReadBestBlock(locator)) {
        locator.SetNull();
    }

    LOCK(cs_main);
    CChain& active_chain = m_chainstate->m_chain;
    if (locator.IsNull()) {
        m_best_block_index = nullptr;
    } else {
        m_best_block_index = m_chainstate->m_blockman.FindForkInGlobalIndex(active_chain, locator);
    }
    m_synced = m_best_block_index.load() == active_chain.Tip();
    if (!m_synced) {
        bool prune_violation = false;
        if (!m_best_block_index) {
            // index is not built yet
            // make sure we have all block data back to the genesis
            const CBlockIndex* block = active_chain.Tip();
            while (block->pprev && (block->pprev->nStatus & BLOCK_HAVE_DATA)) {
                block = block->pprev;
            }
            prune_violation = block != active_chain.Genesis();
        }
        // in case the index has a best block set and is not fully synced
        // check if we have the required blocks to continue building the index
        else {
            const CBlockIndex* block_to_test = m_best_block_index.load();
            if (!active_chain.Contains(block_to_test)) {
                // if the bestblock is not part of the mainchain, find the fork
                // and make sure we have all data down to the fork
                block_to_test = active_chain.FindFork(block_to_test);
            }
            const CBlockIndex* block = active_chain.Tip();
            prune_violation = true;
            // check backwards from the tip if we have all block data until we reach the indexes bestblock
            while (block_to_test && block->pprev && (block->pprev->nStatus & BLOCK_HAVE_DATA)) {
                if (block_to_test == block) {
                    prune_violation = false;
                    break;
                }
                block = block->pprev;
            }
        }
        if (prune_violation) {
            return InitError(strprintf(Untranslated("%s best block of the index goes beyond pruned data. Please disable the index or reindex (which will download the whole blockchain again)"), GetName()));
        }
    }
    return true;
    END
    q:to/END/,
    SetSyscallSandboxPolicy(SyscallSandboxPolicy::TX_INDEX);
    const CBlockIndex* pindex = m_best_block_index.load();
    if (!m_synced) {
        auto& consensus_params = Params().GetConsensus();

        int64_t last_log_time = 0;
        int64_t last_locator_write_time = 0;
        while (true) {
            if (m_interrupt) {
                m_best_block_index = pindex;
                // No need to handle errors in Commit. If it fails, the error will be already be
                // logged. The best way to recover is to continue, as index cannot be corrupted by
                // a missed commit to disk for an advanced index state.
                Commit();
                return;
            }

            {
                LOCK(cs_main);
                const CBlockIndex* pindex_next = NextSyncBlock(pindex, m_chainstate->m_chain);
                if (!pindex_next) {
                    m_best_block_index = pindex;
                    m_synced = true;
                    // No need to handle errors in Commit. See rationale above.
                    Commit();
                    break;
                }
                if (pindex_next->pprev != pindex && !Rewind(pindex, pindex_next->pprev)) {
                    FatalError("%s: Failed to rewind index %s to a previous chain tip",
                               __func__, GetName());
                    return;
                }
                pindex = pindex_next;
            }

            int64_t current_time = GetTime();
            if (last_log_time + SYNC_LOG_INTERVAL < current_time) {
                LogPrintf("Syncing %s with block chain from height %d\n",
                          GetName(), pindex->nHeight);
                last_log_time = current_time;
            }

            if (last_locator_write_time + SYNC_LOCATOR_WRITE_INTERVAL < current_time) {
                m_best_block_index = pindex;
                last_locator_write_time = current_time;
                // No need to handle errors in Commit. See rationale above.
                Commit();
            }

            CBlock block;
            if (!ReadBlockFromDisk(block, pindex, consensus_params)) {
                FatalError("%s: Failed to read block %s from disk",
                           __func__, pindex->GetBlockHash().ToString());
                return;
            }
            if (!WriteBlock(block, pindex)) {
                FatalError("%s: Failed to write block %s to index database",
                           __func__, pindex->GetBlockHash().ToString());
                return;
            }
        }
    }

    if (pindex) {
        LogPrintf("%s is enabled at height %d\n", GetName(), pindex->nHeight);
    } else {
        LogPrintf("%s is enabled\n", GetName());
    }
    END
    q:to/END/,
    CDBBatch batch(GetDB());
    if (!CommitInternal(batch) || !GetDB().WriteBatch(batch)) {
        return error("%s: Failed to commit latest %s state", __func__, GetName());
    }
    return true;
    END
    q:to/END/,
    LOCK(cs_main);
    GetDB().WriteBestBlock(batch, m_chainstate->m_chain.GetLocator(m_best_block_index));
    return true;
    END
    q:to/END/,
    assert(current_tip == m_best_block_index);
    assert(current_tip->GetAncestor(new_tip->nHeight) == new_tip);

    // In the case of a reorg, ensure persisted block locator is not stale.
    // Pruning has a minimum of 288 blocks-to-keep and getting the index
    // out of sync may be possible but a users fault.
    // In case we reorg beyond the pruned depth, ReadBlockFromDisk would
    // throw and lead to a graceful shutdown
    m_best_block_index = new_tip;
    if (!Commit()) {
        // If commit fails, revert the best block index to avoid corruption.
        m_best_block_index = current_tip;
        return false;
    }

    return true;
    END
    q:to/END/,
    if (!m_synced) {
        return;
    }

    const CBlockIndex* best_block_index = m_best_block_index.load();
    if (!best_block_index) {
        if (pindex->nHeight != 0) {
            FatalError("%s: First block connected is not the genesis block (height=%d)",
                       __func__, pindex->nHeight);
            return;
        }
    } else {
        // Ensure block connects to an ancestor of the current best block. This should be the case
        // most of the time, but may not be immediately after the sync thread catches up and sets
        // m_synced. Consider the case where there is a reorg and the blocks on the stale branch are
        // in the ValidationInterface queue backlog even after the sync thread has caught up to the
        // new chain tip. In this unlikely event, log a warning and let the queue clear.
        if (best_block_index->GetAncestor(pindex->nHeight - 1) != pindex->pprev) {
            LogPrintf("%s: WARNING: Block %s does not connect to an ancestor of " 
                      "known best chain (tip=%s); not updating index\n",
                      __func__, pindex->GetBlockHash().ToString(),
                      best_block_index->GetBlockHash().ToString());
            return;
        }
        if (best_block_index != pindex->pprev && !Rewind(best_block_index, pindex->pprev)) {
            FatalError("%s: Failed to rewind index %s to a previous chain tip",
                       __func__, GetName());
            return;
        }
    }

    if (WriteBlock(*block, pindex)) {
        m_best_block_index = pindex;
    } else {
        FatalError("%s: Failed to write block %s to index",
                   __func__, pindex->GetBlockHash().ToString());
        return;
    }
    END
    q:to/END/,
    if (!m_synced) {
        return;
    }

    const uint256& locator_tip_hash = locator.vHave.front();
    const CBlockIndex* locator_tip_index;
    {
        LOCK(cs_main);
        locator_tip_index = m_chainstate->m_blockman.LookupBlockIndex(locator_tip_hash);
    }

    if (!locator_tip_index) {
        FatalError("%s: First block (hash=%s) in locator was not found",
                   __func__, locator_tip_hash.ToString());
        return;
    }

    // This checks that ChainStateFlushed callbacks are received after BlockConnected. The check may fail
    // immediately after the sync thread catches up and sets m_synced. Consider the case where
    // there is a reorg and the blocks on the stale branch are in the ValidationInterface queue
    // backlog even after the sync thread has caught up to the new chain tip. In this unlikely
    // event, log a warning and let the queue clear.
    const CBlockIndex* best_block_index = m_best_block_index.load();
    if (best_block_index->GetAncestor(locator_tip_index->nHeight) != locator_tip_index) {
        LogPrintf("%s: WARNING: Locator contains block (hash=%s) not on known best " 
                  "chain (tip=%s); not writing index locator\n",
                  __func__, locator_tip_hash.ToString(),
                  best_block_index->GetBlockHash().ToString());
        return;
    }

    // No need to handle errors in Commit. If it fails, the error will be already be logged. The
    // best way to recover is to continue, as index cannot be corrupted by a missed commit to disk
    // for an advanced index state.
    Commit();
    END
    q:to/END/,
    AssertLockNotHeld(cs_main);

    if (!m_synced) {
        return false;
    }

    {
        // Skip the queue-draining stuff if we know we're caught up with
        // m_chain.Tip().
        LOCK(cs_main);
        const CBlockIndex* chain_tip = m_chainstate->m_chain.Tip();
        const CBlockIndex* best_block_index = m_best_block_index.load();
        if (best_block_index->GetAncestor(chain_tip->nHeight) == chain_tip) {
            return true;
        }
    }

    LogPrintf("%s: %s is catching up on block notifications\n", __func__, GetName());
    SyncWithValidationInterfaceQueue();
    return true;
    END
    q:to/END/,
    m_chainstate = &active_chainstate;
    // Need to register this ValidationInterface before running Init(), so that
    // callbacks are not missed if Init sets m_synced to true.
    RegisterValidationInterface(this);
    if (!Init()) {
        return false;
    }

    m_thread_sync = std::thread(&util::TraceThread, GetName(), [this] { ThreadSync(); });
    return true;
    END
    q:to/END/,
    UnregisterValidationInterface(this);

    if (m_thread_sync.joinable()) {
        m_thread_sync.join();
    }
    END
    q:to/END/,
    AssertLockHeld(cs_main);

    if (!pindex_prev) {
        return chain.Genesis();
    }

    const CBlockIndex* pindex = chain.Next(pindex_prev);
    if (pindex) {
        return pindex;
    }

    return chain.Next(chain.FindFork(pindex_prev));
    END
    q:to/END/,
    const std::string& filter_name = BlockFilterTypeName(filter_type);
    if (filter_name.empty()) throw std::invalid_argument("unknown filter_type");

    fs::path path = gArgs.GetDataDirNet() / "indexes" / "blockfilter" / filter_name;
    fs::create_directories(path);

    m_name = filter_name + " block filter index";
    m_db = std::make_unique<BaseIndexDB>(path / "db", n_cache_size, f_memory, f_wipe);
    m_filter_fileseq = std::make_unique<FlatFileSeq>(std::move(path), "fltr", FLTR_FILE_CHUNK_SIZE);
    END
    q:to/END/,
    if (!m_db->Read(DB_FILTER_POS, m_next_filter_pos)) {
        // Check that the cause of the read failure is that the key does not exist. Any other errors
        // indicate database corruption or a disk failure, and starting the index would cause
        // further corruption.
        if (m_db->Exists(DB_FILTER_POS)) {
            return error("%s: Cannot read current %s state; index may be corrupted",
                         __func__, GetName());
        }

        // If the DB_FILTER_POS is not set, then initialize to the first location.
        m_next_filter_pos.nFile = 0;
        m_next_filter_pos.nPos = 0;
    }
    return BaseIndex::Init();
    END
    q:to/END/,
    const FlatFilePos& pos = m_next_filter_pos;

    // Flush current filter file to disk.
    CAutoFile file(m_filter_fileseq->Open(pos), SER_DISK, CLIENT_VERSION);
    if (file.IsNull()) {
        return error("%s: Failed to open filter file %d", __func__, pos.nFile);
    }
    if (!FileCommit(file.Get())) {
        return error("%s: Failed to commit filter file %d", __func__, pos.nFile);
    }

    batch.Write(DB_FILTER_POS, pos);
    return BaseIndex::CommitInternal(batch);
    END
    q:to/END/,
    CAutoFile filein(m_filter_fileseq->Open(pos, true), SER_DISK, CLIENT_VERSION);
    if (filein.IsNull()) {
        return false;
    }

    uint256 block_hash;
    std::vector<uint8_t> encoded_filter;
    try {
        filein >> block_hash >> encoded_filter;
        filter = BlockFilter(GetFilterType(), block_hash, std::move(encoded_filter));
    }
    catch (const std::exception& e) {
        return error("%s: Failed to deserialize block filter from disk: %s", __func__, e.what());
    }

    return true;
    END
    q:to/END/,
    assert(filter.GetFilterType() == GetFilterType());

    size_t data_size =
        GetSerializeSize(filter.GetBlockHash(), CLIENT_VERSION) +
        GetSerializeSize(filter.GetEncodedFilter(), CLIENT_VERSION);

    // If writing the filter would overflow the file, flush and move to the next one.
    if (pos.nPos + data_size > MAX_FLTR_FILE_SIZE) {
        CAutoFile last_file(m_filter_fileseq->Open(pos), SER_DISK, CLIENT_VERSION);
        if (last_file.IsNull()) {
            LogPrintf("%s: Failed to open filter file %d\n", __func__, pos.nFile);
            return 0;
        }
        if (!TruncateFile(last_file.Get(), pos.nPos)) {
            LogPrintf("%s: Failed to truncate filter file %d\n", __func__, pos.nFile);
            return 0;
        }
        if (!FileCommit(last_file.Get())) {
            LogPrintf("%s: Failed to commit filter file %d\n", __func__, pos.nFile);
            return 0;
        }

        pos.nFile++;
        pos.nPos = 0;
    }

    // Pre-allocate sufficient space for filter data.
    bool out_of_space;
    m_filter_fileseq->Allocate(pos, data_size, out_of_space);
    if (out_of_space) {
        LogPrintf("%s: out of disk space\n", __func__);
        return 0;
    }

    CAutoFile fileout(m_filter_fileseq->Open(pos), SER_DISK, CLIENT_VERSION);
    if (fileout.IsNull()) {
        LogPrintf("%s: Failed to open filter file %d\n", __func__, pos.nFile);
        return 0;
    }

    fileout << filter.GetBlockHash() << filter.GetEncodedFilter();
    return data_size;
    END
    q:to/END/,
    CBlockUndo block_undo;
    uint256 prev_header;

    if (pindex->nHeight > 0) {
        if (!UndoReadFromDisk(block_undo, pindex)) {
            return false;
        }

        std::pair<uint256, DBVal> read_out;
        if (!m_db->Read(DBHeightKey(pindex->nHeight - 1), read_out)) {
            return false;
        }

        uint256 expected_block_hash = pindex->pprev->GetBlockHash();
        if (read_out.first != expected_block_hash) {
            return error("%s: previous block header belongs to unexpected block %s; expected %s",
                         __func__, read_out.first.ToString(), expected_block_hash.ToString());
        }

        prev_header = read_out.second.header;
    }

    BlockFilter filter(m_filter_type, block, block_undo);

    size_t bytes_written = WriteFilterToDisk(m_next_filter_pos, filter);
    if (bytes_written == 0) return false;

    std::pair<uint256, DBVal> value;
    value.first = pindex->GetBlockHash();
    value.second.hash = filter.GetHash();
    value.second.header = filter.ComputeHeader(prev_header);
    value.second.pos = m_next_filter_pos;

    if (!m_db->Write(DBHeightKey(pindex->nHeight), value)) {
        return false;
    }

    m_next_filter_pos.nPos += bytes_written;
    return true;
    END
    q:to/END/,
    assert(current_tip->GetAncestor(new_tip->nHeight) == new_tip);

    CDBBatch batch(*m_db);
    std::unique_ptr<CDBIterator> db_it(m_db->NewIterator());

    // During a reorg, we need to copy all filters for blocks that are getting disconnected from the
    // height index to the hash index so we can still find them when the height index entries are
    // overwritten.
    if (!CopyHeightIndexToHashIndex(*db_it, batch, m_name, new_tip->nHeight, current_tip->nHeight)) {
        return false;
    }

    // The latest filter position gets written in Commit by the call to the BaseIndex::Rewind.
    // But since this creates new references to the filter, the position should get updated here
    // atomically as well in case Commit fails.
    batch.Write(DB_FILTER_POS, m_next_filter_pos);
    if (!m_db->WriteBatch(batch)) return false;

    return BaseIndex::Rewind(current_tip, new_tip);
    END
    q:to/END/,
    DBVal entry;
    if (!LookupOne(*m_db, block_index, entry)) {
        return false;
    }

    return ReadFilterFromDisk(entry.pos, filter_out);
    END
    q:to/END/,
    LOCK(m_cs_headers_cache);

    bool is_checkpoint{block_index->nHeight % CFCHECKPT_INTERVAL == 0};

    if (is_checkpoint) {
        // Try to find the block in the headers cache if this is a checkpoint height.
        auto header = m_headers_cache.find(block_index->GetBlockHash());
        if (header != m_headers_cache.end()) {
            header_out = header->second;
            return true;
        }
    }

    DBVal entry;
    if (!LookupOne(*m_db, block_index, entry)) {
        return false;
    }

    if (is_checkpoint &&
        m_headers_cache.size() < CF_HEADERS_CACHE_MAX_SZ) {
        // Add to the headers cache if this is a checkpoint height.
        m_headers_cache.emplace(block_index->GetBlockHash(), entry.header);
    }

    header_out = entry.header;
    return true;
    END
    q:to/END/,
    std::vector<DBVal> entries;
    if (!LookupRange(*m_db, m_name, start_height, stop_index, entries)) {
        return false;
    }

    filters_out.resize(entries.size());
    auto filter_pos_it = filters_out.begin();
    for (const auto& entry : entries) {
        if (!ReadFilterFromDisk(entry.pos, *filter_pos_it)) {
            return false;
        }
        ++filter_pos_it;
    }

    return true;
    END
    q:to/END/,
    std::vector<DBVal> entries;
    if (!LookupRange(*m_db, m_name, start_height, stop_index, entries)) {
        return false;
    }

    hashes_out.clear();
    hashes_out.reserve(entries.size());
    for (const auto& entry : entries) {
        hashes_out.push_back(entry.hash);
    }
    return true;
    END
    q:to/END/,
    auto it = g_filter_indexes.find(filter_type);
    return it != g_filter_indexes.end() ? &it->second : nullptr;
    END
    q:to/END/,
    auto result = g_filter_indexes.emplace(std::piecewise_construct,
                                           std::forward_as_tuple(filter_type),
                                           std::forward_as_tuple(filter_type,
                                                                 n_cache_size, f_memory, f_wipe));
    return result.second;
    END
    q:to/END/,
    // First check if the result is stored under the height index and the value there matches the
    // block hash. This should be the case if the block is on the active chain.
    std::pair<uint256, DBVal> read_out;
    if (!db.Read(DBHeightKey(block_index->nHeight), read_out)) {
        return false;
    }
    if (read_out.first == block_index->GetBlockHash()) {
        result = std::move(read_out.second);
        return true;
    }

    // If value at the height index corresponds to an different block, the result will be stored in
    // the hash index.
    return db.Read(DBHashKey(block_index->GetBlockHash()), result);
    END
    q:to/END/,
    if (start_height < 0) {
        return error("%s: start height (%d) is negative", __func__, start_height);
    }
    if (start_height > stop_index->nHeight) {
        return error("%s: start height (%d) is greater than stop height (%d)",
                     __func__, start_height, stop_index->nHeight);
    }

    size_t results_size = static_cast<size_t>(stop_index->nHeight - start_height + 1);
    std::vector<std::pair<uint256, DBVal>> values(results_size);

    DBHeightKey key(start_height);
    std::unique_ptr<CDBIterator> db_it(db.NewIterator());
    db_it->Seek(DBHeightKey(start_height));
    for (int height = start_height; height <= stop_index->nHeight; ++height) {
        if (!db_it->Valid() || !db_it->GetKey(key) || key.height != height) {
            return false;
        }

        size_t i = static_cast<size_t>(height - start_height);
        if (!db_it->GetValue(values[i])) {
            return error("%s: unable to read value in %s at key (%c, %d)",
                         __func__, index_name, DB_BLOCK_HEIGHT, height);
        }

        db_it->Next();
    }

    results.resize(results_size);

    // Iterate backwards through block indexes collecting results in order to access the block hash
    // of each entry in case we need to look it up in the hash index.
    for (const CBlockIndex* block_index = stop_index;
         block_index && block_index->nHeight >= start_height;
         block_index = block_index->pprev) {
        uint256 block_hash = block_index->GetBlockHash();

        size_t i = static_cast<size_t>(block_index->nHeight - start_height);
        if (block_hash == values[i].first) {
            results[i] = std::move(values[i].second);
            continue;
        }

        if (!db.Read(DBHashKey(block_hash), results[i])) {
            return error("%s: unable to read value in %s at key (%c, %s)",
                         __func__, index_name, DB_BLOCK_HASH, block_hash.ToString());
        }
    }

    return true;
    END
    q:to/END/,
    DBHeightKey key(start_height);
    db_it.Seek(key);

    for (int height = start_height; height <= stop_height; ++height) {
        if (!db_it.GetKey(key) || key.height != height) {
            return error("%s: unexpected key in %s: expected (%c, %d)",
                         __func__, index_name, DB_BLOCK_HEIGHT, height);
        }

        std::pair<uint256, DBVal> value;
        if (!db_it.GetValue(value)) {
            return error("%s: unable to read value in %s at key (%c, %d)",
                         __func__, index_name, DB_BLOCK_HEIGHT, height);
        }

        batch.Write(DBHashKey(value.first), std::move(value.second));

        db_it.Next();
    }
    return true;
    END
    q:to/END/,
    CBlockUndo block_undo;
    const CAmount block_subsidy{GetBlockSubsidy(pindex->nHeight, Params().GetConsensus())};
    m_total_subsidy += block_subsidy;

    // Ignore genesis block
    if (pindex->nHeight > 0) {
        if (!UndoReadFromDisk(block_undo, pindex)) {
            return false;
        }

        std::pair<uint256, DBVal> read_out;
        if (!m_db->Read(DBHeightKey(pindex->nHeight - 1), read_out)) {
            return false;
        }

        uint256 expected_block_hash{pindex->pprev->GetBlockHash()};
        if (read_out.first != expected_block_hash) {
            LogPrintf("WARNING: previous block header belongs to unexpected block %s; expected %s\n",
                      read_out.first.ToString(), expected_block_hash.ToString());

            if (!m_db->Read(DBHashKey(expected_block_hash), read_out)) {
                return error("%s: previous block header not found; expected %s",
                             __func__, expected_block_hash.ToString());
            }
        }

        // TODO: Deduplicate BIP30 related code
        bool is_bip30_block{(pindex->nHeight == 91722 && pindex->GetBlockHash() == uint256S("0x00000000000271a2dc26e7667f8419f2e15416dc6955e5a6c6cdf3f2574dd08e")) ||
                            (pindex->nHeight == 91812 && pindex->GetBlockHash() == uint256S("0x00000000000af0aed4792b1acee3d966af36cf5def14935db8de83d6f9306f2f"))};

        // Add the new utxos created from the block
        for (size_t i = 0; i < block.vtx.size(); ++i) {
            const auto& tx{block.vtx.at(i)};

            // Skip duplicate txid coinbase transactions (BIP30).
            if (is_bip30_block && tx->IsCoinBase()) {
                m_total_unspendable_amount += block_subsidy;
                m_total_unspendables_bip30 += block_subsidy;
                continue;
            }

            for (uint32_t j = 0; j < tx->vout.size(); ++j) {
                const CTxOut& out{tx->vout[j]};
                Coin coin{out, pindex->nHeight, tx->IsCoinBase()};
                OutPoint outpoint{tx->GetHash(), j};

                // Skip unspendable coins
                if (coin.out.scriptPubKey.IsUnspendable()) {
                    m_total_unspendable_amount += coin.out.nValue;
                    m_total_unspendables_scripts += coin.out.nValue;
                    continue;
                }

                m_muhash.Insert(MakeUCharSpan(TxOutSer(outpoint, coin)));

                if (tx->IsCoinBase()) {
                    m_total_coinbase_amount += coin.out.nValue;
                } else {
                    m_total_new_outputs_ex_coinbase_amount += coin.out.nValue;
                }

                ++m_transaction_output_count;
                m_total_amount += coin.out.nValue;
                m_bogo_size += GetBogoSize(coin.out.scriptPubKey);
            }

            // The coinbase tx has no undo data since no former output is spent
            if (!tx->IsCoinBase()) {
                const auto& tx_undo{block_undo.vtxundo.at(i - 1)};

                for (size_t j = 0; j < tx_undo.vprevout.size(); ++j) {
                    Coin coin{tx_undo.vprevout[j]};
                    OutPoint outpoint{tx->vin[j].prevout.hash, tx->vin[j].prevout.n};

                    m_muhash.Remove(MakeUCharSpan(TxOutSer(outpoint, coin)));

                    m_total_prevout_spent_amount += coin.out.nValue;

                    --m_transaction_output_count;
                    m_total_amount -= coin.out.nValue;
                    m_bogo_size -= GetBogoSize(coin.out.scriptPubKey);
                }
            }
        }
    } else {
        // genesis block
        m_total_unspendable_amount += block_subsidy;
        m_total_unspendables_genesis_block += block_subsidy;
    }

    // If spent prevouts + block subsidy are still a higher amount than
    // new outputs + coinbase + current unspendable amount this means
    // the miner did not claim the full block reward. Unclaimed block
    // rewards are also unspendable.
    const CAmount unclaimed_rewards{(m_total_prevout_spent_amount + m_total_subsidy) - (m_total_new_outputs_ex_coinbase_amount + m_total_coinbase_amount + m_total_unspendable_amount)};
    m_total_unspendable_amount += unclaimed_rewards;
    m_total_unspendables_unclaimed_rewards += unclaimed_rewards;

    std::pair<uint256, DBVal> value;
    value.first = pindex->GetBlockHash();
    value.second.transaction_output_count = m_transaction_output_count;
    value.second.bogo_size = m_bogo_size;
    value.second.total_amount = m_total_amount;
    value.second.total_subsidy = m_total_subsidy;
    value.second.total_unspendable_amount = m_total_unspendable_amount;
    value.second.total_prevout_spent_amount = m_total_prevout_spent_amount;
    value.second.total_new_outputs_ex_coinbase_amount = m_total_new_outputs_ex_coinbase_amount;
    value.second.total_coinbase_amount = m_total_coinbase_amount;
    value.second.total_unspendables_genesis_block = m_total_unspendables_genesis_block;
    value.second.total_unspendables_bip30 = m_total_unspendables_bip30;
    value.second.total_unspendables_scripts = m_total_unspendables_scripts;
    value.second.total_unspendables_unclaimed_rewards = m_total_unspendables_unclaimed_rewards;

    uint256 out;
    m_muhash.Finalize(out);
    value.second.muhash = out;

    CDBBatch batch(*m_db);
    batch.Write(DBHeightKey(pindex->nHeight), value);
    batch.Write(DB_MUHASH, m_muhash);
    return m_db->WriteBatch(batch);
    END
    q:to/END/,
    assert(current_tip->GetAncestor(new_tip->nHeight) == new_tip);

    CDBBatch batch(*m_db);
    std::unique_ptr<CDBIterator> db_it(m_db->NewIterator());

    // During a reorg, we need to copy all hash digests for blocks that are
    // getting disconnected from the height index to the hash index so we can
    // still find them when the height index entries are overwritten.
    if (!CopyHeightIndexToHashIndex(*db_it, batch, m_name, new_tip->nHeight, current_tip->nHeight)) {
        return false;
    }

    if (!m_db->WriteBatch(batch)) return false;

    {
        LOCK(cs_main);
        CBlockIndex* iter_tip{m_chainstate->m_blockman.LookupBlockIndex(current_tip->GetBlockHash())};
        const auto& consensus_params{Params().GetConsensus()};

        do {
            CBlock block;

            if (!ReadBlockFromDisk(block, iter_tip, consensus_params)) {
                return error("%s: Failed to read block %s from disk",
                             __func__, iter_tip->GetBlockHash().ToString());
            }

            ReverseBlock(block, iter_tip);

            iter_tip = iter_tip->GetAncestor(iter_tip->nHeight - 1);
        } while (new_tip != iter_tip);
    }

    return BaseIndex::Rewind(current_tip, new_tip);
    END
    q:to/END/,
    DBVal entry;
    if (!LookUpOne(*m_db, block_index, entry)) {
        return false;
    }

    coins_stats.hashSerialized = entry.muhash;
    coins_stats.nTransactionOutputs = entry.transaction_output_count;
    coins_stats.nBogoSize = entry.bogo_size;
    coins_stats.nTotalAmount = entry.total_amount;
    coins_stats.total_subsidy = entry.total_subsidy;
    coins_stats.total_unspendable_amount = entry.total_unspendable_amount;
    coins_stats.total_prevout_spent_amount = entry.total_prevout_spent_amount;
    coins_stats.total_new_outputs_ex_coinbase_amount = entry.total_new_outputs_ex_coinbase_amount;
    coins_stats.total_coinbase_amount = entry.total_coinbase_amount;
    coins_stats.total_unspendables_genesis_block = entry.total_unspendables_genesis_block;
    coins_stats.total_unspendables_bip30 = entry.total_unspendables_bip30;
    coins_stats.total_unspendables_scripts = entry.total_unspendables_scripts;
    coins_stats.total_unspendables_unclaimed_rewards = entry.total_unspendables_unclaimed_rewards;

    return true;
    END
    q:to/END/,
    if (!m_db->Read(DB_MUHASH, m_muhash)) {
        // Check that the cause of the read failure is that the key does not
        // exist. Any other errors indicate database corruption or a disk
        // failure, and starting the index would cause further corruption.
        if (m_db->Exists(DB_MUHASH)) {
            return error("%s: Cannot read current %s state; index may be corrupted",
                         __func__, GetName());
        }
    }

    if (!BaseIndex::Init()) return false;

    const CBlockIndex* pindex{CurrentIndex()};

    if (pindex) {
        DBVal entry;
        if (!LookUpOne(*m_db, pindex, entry)) {
            return false;
        }

        m_transaction_output_count = entry.transaction_output_count;
        m_bogo_size = entry.bogo_size;
        m_total_amount = entry.total_amount;
        m_total_subsidy = entry.total_subsidy;
        m_total_unspendable_amount = entry.total_unspendable_amount;
        m_total_prevout_spent_amount = entry.total_prevout_spent_amount;
        m_total_new_outputs_ex_coinbase_amount = entry.total_new_outputs_ex_coinbase_amount;
        m_total_coinbase_amount = entry.total_coinbase_amount;
        m_total_unspendables_genesis_block = entry.total_unspendables_genesis_block;
        m_total_unspendables_bip30 = entry.total_unspendables_bip30;
        m_total_unspendables_scripts = entry.total_unspendables_scripts;
        m_total_unspendables_unclaimed_rewards = entry.total_unspendables_unclaimed_rewards;
    }

    return true;
    END
    q:to/END/,
    CBlockUndo block_undo;
    std::pair<uint256, DBVal> read_out;

    const CAmount block_subsidy{GetBlockSubsidy(pindex->nHeight, Params().GetConsensus())};
    m_total_subsidy -= block_subsidy;

    // Ignore genesis block
    if (pindex->nHeight > 0) {
        if (!UndoReadFromDisk(block_undo, pindex)) {
            return false;
        }

        if (!m_db->Read(DBHeightKey(pindex->nHeight - 1), read_out)) {
            return false;
        }

        uint256 expected_block_hash{pindex->pprev->GetBlockHash()};
        if (read_out.first != expected_block_hash) {
            LogPrintf("WARNING: previous block header belongs to unexpected block %s; expected %s\n",
                      read_out.first.ToString(), expected_block_hash.ToString());

            if (!m_db->Read(DBHashKey(expected_block_hash), read_out)) {
                return error("%s: previous block header not found; expected %s",
                             __func__, expected_block_hash.ToString());
            }
        }
    }

    // Remove the new UTXOs that were created from the block
    for (size_t i = 0; i < block.vtx.size(); ++i) {
        const auto& tx{block.vtx.at(i)};

        for (uint32_t j = 0; j < tx->vout.size(); ++j) {
            const CTxOut& out{tx->vout[j]};
            OutPoint outpoint{tx->GetHash(), j};
            Coin coin{out, pindex->nHeight, tx->IsCoinBase()};

            // Skip unspendable coins
            if (coin.out.scriptPubKey.IsUnspendable()) {
                m_total_unspendable_amount -= coin.out.nValue;
                m_total_unspendables_scripts -= coin.out.nValue;
                continue;
            }

            m_muhash.Remove(MakeUCharSpan(TxOutSer(outpoint, coin)));

            if (tx->IsCoinBase()) {
                m_total_coinbase_amount -= coin.out.nValue;
            } else {
                m_total_new_outputs_ex_coinbase_amount -= coin.out.nValue;
            }

            --m_transaction_output_count;
            m_total_amount -= coin.out.nValue;
            m_bogo_size -= GetBogoSize(coin.out.scriptPubKey);
        }

        // The coinbase tx has no undo data since no former output is spent
        if (!tx->IsCoinBase()) {
            const auto& tx_undo{block_undo.vtxundo.at(i - 1)};

            for (size_t j = 0; j < tx_undo.vprevout.size(); ++j) {
                Coin coin{tx_undo.vprevout[j]};
                OutPoint outpoint{tx->vin[j].prevout.hash, tx->vin[j].prevout.n};

                m_muhash.Insert(MakeUCharSpan(TxOutSer(outpoint, coin)));

                m_total_prevout_spent_amount -= coin.out.nValue;

                m_transaction_output_count++;
                m_total_amount += coin.out.nValue;
                m_bogo_size += GetBogoSize(coin.out.scriptPubKey);
            }
        }
    }

    const CAmount unclaimed_rewards{(m_total_new_outputs_ex_coinbase_amount + m_total_coinbase_amount + m_total_unspendable_amount) - (m_total_prevout_spent_amount + m_total_subsidy)};
    m_total_unspendable_amount -= unclaimed_rewards;
    m_total_unspendables_unclaimed_rewards -= unclaimed_rewards;

    // Check that the rolled back internal values are consistent with the DB read out
    uint256 out;
    m_muhash.Finalize(out);
    Assert(read_out.second.muhash == out);

    Assert(m_transaction_output_count == read_out.second.transaction_output_count);
    Assert(m_total_amount == read_out.second.total_amount);
    Assert(m_bogo_size == read_out.second.bogo_size);
    Assert(m_total_subsidy == read_out.second.total_subsidy);
    Assert(m_total_unspendable_amount == read_out.second.total_unspendable_amount);
    Assert(m_total_prevout_spent_amount == read_out.second.total_prevout_spent_amount);
    Assert(m_total_new_outputs_ex_coinbase_amount == read_out.second.total_new_outputs_ex_coinbase_amount);
    Assert(m_total_coinbase_amount == read_out.second.total_coinbase_amount);
    Assert(m_total_unspendables_genesis_block == read_out.second.total_unspendables_genesis_block);
    Assert(m_total_unspendables_bip30 == read_out.second.total_unspendables_bip30);
    Assert(m_total_unspendables_scripts == read_out.second.total_unspendables_scripts);
    Assert(m_total_unspendables_unclaimed_rewards == read_out.second.total_unspendables_unclaimed_rewards);

    return m_db->Write(DB_MUHASH, m_muhash);
    END
    q:to/END/,
    const uint8_t prefix{ser_readdata8(s)};
    if (prefix != DB_BLOCK_HEIGHT) {
        throw std::ios_base::failure("Invalid format for coinstatsindex DB height key");
    }
    height = ser_readdata32be(s);
    END
    q:to/END/,
    // First check if the result is stored under the height index and the value
    // there matches the block hash. This should be the case if the block is on
    // the active chain.
    std::pair<uint256, DBVal> read_out;
    if (!db.Read(DBHeightKey(block_index->nHeight), read_out)) {
        return false;
    }
    if (read_out.first == block_index->GetBlockHash()) {
        result = std::move(read_out.second);
        return true;
    }

    // If value at the height index corresponds to an different block, the
    // result will be stored in the hash index.
    return db.Read(DBHashKey(block_index->GetBlockHash()), result);
    END
    q:to/END/,
    DBHeightKey key{start_height};
    db_it.Seek(key);

    for (int height = start_height; height <= stop_height; ++height) {
        if (!db_it.GetKey(key) || key.height != height) {
            return error("%s: unexpected key in %s: expected (%c, %d)",
                         __func__, index_name, DB_BLOCK_HEIGHT, height);
        }

        std::pair<uint256, DBVal> value;
        if (!db_it.GetValue(value)) {
            return error("%s: unable to read value in %s at key (%c, %d)",
                         __func__, index_name, DB_BLOCK_HEIGHT, height);
        }

        batch.Write(DBHashKey(value.first), std::move(value.second));

        db_it.Next();
    }
    return true;
    END
    q:to/END/,
    FlatFilePos::SetNull();
    nTxOffset = 0;
    END
    q:to/END/,
    // Exclude genesis block transaction because outputs are not spendable.
    if (pindex->nHeight == 0) return true;

    CDiskTxPos pos(pindex->GetBlockPos(), GetSizeOfCompactSize(block.vtx.size()));
    std::vector<std::pair<uint256, CDiskTxPos>> vPos;
    vPos.reserve(block.vtx.size());
    for (const auto& tx : block.vtx) {
        vPos.emplace_back(tx->GetHash(), pos);
        pos.nTxOffset += ::GetSerializeSize(*tx, CLIENT_VERSION);
    }
    return m_db->WriteTxs(vPos);
    END
    q:to/END/,
    CDiskTxPos postx;
    if (!m_db->ReadTxPos(tx_hash, postx)) {
        return false;
    }

    CAutoFile file(OpenBlockFile(postx, true), SER_DISK, CLIENT_VERSION);
    if (file.IsNull()) {
        return error("%s: OpenBlockFile failed", __func__);
    }
    CBlockHeader header;
    try {
        file >> header;
        if (fseek(file.Get(), postx.nTxOffset, SEEK_CUR)) {
            return error("%s: fseek(...) failed", __func__);
        }
        file >> tx;
    } catch (const std::exception& e) {
        return error("%s: Deserialize or I/O error - %s", __func__, e.what());
    }
    if (tx->GetHash() != tx_hash) {
        return error("%s: txid mismatch", __func__);
    }
    block_hash = header.GetHash();
    return true;
    END
    q:to/END/,
    CDBBatch batch(*this);
    for (const auto& tuple : v_pos) {
        batch.Write(std::make_pair(DB_TXINDEX, tuple.first), tuple.second);
    }
    return WriteBatch(batch);
    END
    q:to/END/,
    Reset();

    LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::MakeMock\n");

    dbenv->set_cachesize(1, 0, 1);
    dbenv->set_lg_bsize(10485760 * 4);
    dbenv->set_lg_max(10485760);
    dbenv->set_lk_max_locks(10000);
    dbenv->set_lk_max_objects(10000);
    dbenv->set_flags(DB_AUTO_COMMIT, 1);
    dbenv->log_set_config(DB_LOG_IN_MEMORY, 1);
    int ret = dbenv->open(nullptr,
                         DB_CREATE |
                             DB_INIT_LOCK |
                             DB_INIT_LOG |
                             DB_INIT_MPOOL |
                             DB_INIT_TXN |
                             DB_THREAD |
                             DB_PRIVATE,
                         S_IRUSR | S_IWUSR);
    if (ret > 0) {
        throw std::runtime_error(strprintf("BerkeleyEnvironment::MakeMock: Error %d opening database environment.", ret));
    }

    fDbEnvInit = true;
    fMockDb = true;
    END
    q:to/END/,
    DbTxn* ptxn = nullptr;
    int ret = dbenv->txn_begin(nullptr, &ptxn, flags);
    if (!ptxn || ret != 0)
        return nullptr;
    return ptxn;
    END
    q:to/END/,
    {
        LOCK(cs_db);
        auto it = m_databases.find(strFile);
        assert(it != m_databases.end());
        BerkeleyDatabase& database = it->second.get();
        if (database.m_db) {
            // Close the database handle
            database.m_db->close(0);
            database.m_db.reset();
        }
    }
    END
    q:to/END/,
    // Make sure that no Db's are in use
    AssertLockNotHeld(cs_db);
    std::unique_lock<RecursiveMutex> lock(cs_db);
    m_db_in_use.wait(lock, [this](){
        for (auto& db : m_databases) {
            if (db.second.get().m_refcount > 0) return false;
        }
        return true;
    });

    std::vector<std::string> filenames;
    for (auto it : m_databases) {
        filenames.push_back(it.first);
    }
    // Close the individual Db's
    for (const std::string& filename : filenames) {
        CloseDb(filename);
    }
    // Reset the environment
    Flush(true); // This will flush and close the environment
    Reset();
    bilingual_str open_err;
    Open(open_err);
    END
    q:to/END/,
    if (!fDbEnvInit)
        return;

    fDbEnvInit = false;

    for (auto& db : m_databases) {
        BerkeleyDatabase& database = db.second.get();
        assert(database.m_refcount <= 0);
        if (database.m_db) {
            database.m_db->close(0);
            database.m_db.reset();
        }
    }

    FILE* error_file = nullptr;
    dbenv->get_errfile(&error_file);

    int ret = dbenv->close(0);
    if (ret != 0)
        LogPrintf("BerkeleyEnvironment::Close: Error %d closing database environment: %s\n", ret, DbEnv::strerror(ret));
    if (!fMockDb)
        DbEnv((u_int32_t)0).remove(strPath.c_str(), 0);

    if (error_file) fclose(error_file);

    UnlockDirectory(fs::PathFromString(strPath), ".walletlock");
    END
    q:to/END/,
    dbenv.reset(new DbEnv(DB_CXX_NO_EXCEPTIONS));
    fDbEnvInit = false;
    fMockDb = false;
    END
    q:to/END/,
    if (fDbEnvInit) {
        return true;
    }

    fs::path pathIn = fs::PathFromString(strPath);
    TryCreateDirectories(pathIn);
    if (!LockDirectory(pathIn, ".walletlock")) {
        LogPrintf("Cannot obtain a lock on wallet directory %s. Another instance may be using it.\n", strPath);
        err = strprintf(_("Error initializing wallet database environment %s!"), fs::quoted(fs::PathToString(Directory())));
        return false;
    }

    fs::path pathLogDir = pathIn / "database";
    TryCreateDirectories(pathLogDir);
    fs::path pathErrorFile = pathIn / "db.log";
    LogPrintf("BerkeleyEnvironment::Open: LogDir=%s ErrorFile=%s\n", fs::PathToString(pathLogDir), fs::PathToString(pathErrorFile));

    unsigned int nEnvFlags = 0;
    if (gArgs.GetBoolArg("-privdb", DEFAULT_WALLET_PRIVDB))
        nEnvFlags |= DB_PRIVATE;

    dbenv->set_lg_dir(fs::PathToString(pathLogDir).c_str());
    dbenv->set_cachesize(0, 0x100000, 1); // 1 MiB should be enough for just the wallet
    dbenv->set_lg_bsize(0x10000);
    dbenv->set_lg_max(1048576);
    dbenv->set_lk_max_locks(40000);
    dbenv->set_lk_max_objects(40000);
    dbenv->set_errfile(fsbridge::fopen(pathErrorFile, "a")); /// debug
    dbenv->set_flags(DB_AUTO_COMMIT, 1);
    dbenv->set_flags(DB_TXN_WRITE_NOSYNC, 1);
    dbenv->log_set_config(DB_LOG_AUTO_REMOVE, 1);
    int ret = dbenv->open(strPath.c_str(),
                         DB_CREATE |
                             DB_INIT_LOCK |
                             DB_INIT_LOG |
                             DB_INIT_MPOOL |
                             DB_INIT_TXN |
                             DB_THREAD |
                             DB_RECOVER |
                             nEnvFlags,
                         S_IRUSR | S_IWUSR);
    if (ret != 0) {
        LogPrintf("BerkeleyEnvironment::Open: Error %d opening database environment: %s\n", ret, DbEnv::strerror(ret));
        int ret2 = dbenv->close(0);
        if (ret2 != 0) {
            LogPrintf("BerkeleyEnvironment::Open: Error %d closing failed database environment: %s\n", ret2, DbEnv::strerror(ret2));
        }
        Reset();
        err = strprintf(_("Error initializing wallet database environment %s!"), fs::quoted(fs::PathToString(Directory())));
        if (ret == DB_RUNRECOVERY) {
            err += Untranslated(" ") + _("This error could occur if this wallet was not shutdown cleanly and was last loaded using a build with a newer version of Berkeley DB. If so, please use the software that last loaded this wallet");
        }
        return false;
    }

    fDbEnvInit = true;
    fMockDb = false;
    return true;
    END
    q:to/END/,
    dbenv->txn_checkpoint(0, 0, 0);
    if (fMockDb)
        return;
    dbenv->lsn_reset(strFile.c_str(), 0);
    END
    q:to/END/,
    int64_t nStart = GetTimeMillis();
    // Flush log data to the actual data file on all files that are not in use
    LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: [%s] Flush(%s)%s\n", strPath, fShutdown ? "true" : "false", fDbEnvInit ? "" : " database not started");
    if (!fDbEnvInit)
        return;
    {
        LOCK(cs_db);
        bool no_dbs_accessed = true;
        for (auto& db_it : m_databases) {
            std::string strFile = db_it.first;
            int nRefCount = db_it.second.get().m_refcount;
            if (nRefCount < 0) continue;
            LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: Flushing %s (refcount = %d)...\n", strFile, nRefCount);
            if (nRefCount == 0) {
                // Move log data to the dat file
                CloseDb(strFile);
                LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: %s checkpoint\n", strFile);
                dbenv->txn_checkpoint(0, 0, 0);
                LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: %s detach\n", strFile);
                if (!fMockDb)
                    dbenv->lsn_reset(strFile.c_str(), 0);
                LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: %s closed\n", strFile);
                nRefCount = -1;
            } else {
                no_dbs_accessed = false;
            }
        }
        LogPrint(BCLog::WALLETDB, "BerkeleyEnvironment::Flush: Flush(%s)%s took %15dms\n", fShutdown ? "true" : "false", fDbEnvInit ? "" : " database not started", GetTimeMillis() - nStart);
        if (fShutdown) {
            char** listp;
            if (no_dbs_accessed) {
                dbenv->log_archive(&listp, DB_ARCH_REMOVE);
                Close();
                if (!fMockDb) {
                    fs::remove_all(fs::PathFromString(strPath) / "database");
                }
            }
        }
    }
    END
    q:to/END/,
    fs::path walletDir = env->Directory();
    fs::path file_path = walletDir / strFile;

    LogPrintf("Using BerkeleyDB version %s\n", BerkeleyDatabaseVersion());
    LogPrintf("Using wallet %s\n", fs::PathToString(file_path));

    if (!env->Open(errorStr)) {
        return false;
    }

    if (fs::exists(file_path))
    {
        assert(m_refcount == 0);

        Db db(env->dbenv.get(), 0);
        int result = db.verify(strFile.c_str(), nullptr, nullptr, 0);
        if (result != 0) {
            errorStr = strprintf(_("%s corrupt. Try using the wallet tool bitcoin-wallet to salvage or restoring a backup."), fs::quoted(fs::PathToString(file_path)));
            return false;
        }
    }
    // also return true if files does not exists
    return true;
    END
    q:to/END/,
    auto node_context = util::AnyPtr<NodeContext>(context);
    if (!node_context) {
        throw JSONRPCError(RPC_INTERNAL_ERROR, "Node context not found");
    }
    return *node_context;
    END
    q:to/END/,
    auto node_context = util::AnyPtr<NodeContext>(context);
    if (!node_context) {
        throw JSONRPCError(RPC_INTERNAL_ERROR, "Node context not found");
    }
    return *node_context;
    END
    q:to/END/,
    if (!node.chainman) {
        throw JSONRPCError(RPC_INTERNAL_ERROR, "Node chainman not found");
    }
    return *node.chainman;
    END
    q:to/END/,
    CHECK_NONFATAL(blockindex);

    int nShift = (blockindex->nBits >> 24) & 0xff;
    double dDiff =
        (double)0x0000ffff / (double)(blockindex->nBits & 0x00ffffff);

    while (nShift < 29)
    {
        dDiff *= 256.0;
        nShift++;
    }
    while (nShift > 29)
    {
        dDiff /= 256.0;
        nShift--;
    }

    return dDiff;
    END
    q:to/END/,
    next = tip->GetAncestor(blockindex->nHeight + 1);
    if (next && next->pprev == blockindex) {
        return tip->nHeight - blockindex->nHeight + 1;
    }
    next = nullptr;
    return blockindex == tip ? 1 : -1;
    END
    q:to/END/,
    LOCK(::cs_main);
    CChain& active_chain = chainman.ActiveChain();

    if (param.isNum()) {
        const int height{param.get_int()};
        if (height < 0) {
            throw JSONRPCError(RPC_INVALID_PARAMETER, strprintf("Target block height %d is negative", height));
        }
        const int current_tip{active_chain.Height()};
        if (height > current_tip) {
            throw JSONRPCError(RPC_INVALID_PARAMETER, strprintf("Target block height %d after current tip %d", height, current_tip));
        }

        return active_chain[height];
    } else {
        const uint256 hash{ParseHashV(param, "hash_or_height")};
        CBlockIndex* pindex = chainman.m_blockman.LookupBlockIndex(hash);

        if (!pindex) {
            throw JSONRPCError(RPC_INVALID_ADDRESS_OR_KEY, "Block not found");
        }

        return pindex;
    }
    END
    q:to/END/,
    // Serialize passed information without accessing chain state of the active chain!
    AssertLockNotHeld(cs_main); // For performance reasons

    UniValue result(UniValue::VOBJ);
    result.pushKV("hash", blockindex->GetBlockHash().GetHex());
    const CBlockIndex* pnext;
    int confirmations = ComputeNextBlockAndDepth(tip, blockindex, pnext);
    result.pushKV("confirmations", confirmations);
    result.pushKV("height", blockindex->nHeight);
    result.pushKV("version", blockindex->nVersion);
    result.pushKV("versionHex", strprintf("%08x", blockindex->nVersion));
    result.pushKV("merkleroot", blockindex->hashMerkleRoot.GetHex());
    result.pushKV("time", (int64_t)blockindex->nTime);
    result.pushKV("mediantime", (int64_t)blockindex->GetMedianTimePast());
    result.pushKV("nonce", (uint64_t)blockindex->nNonce);
    result.pushKV("bits", strprintf("%08x", blockindex->nBits));
    result.pushKV("difficulty", GetDifficulty(blockindex));
    result.pushKV("chainwork", blockindex->nChainWork.GetHex());
    result.pushKV("nTx", (uint64_t)blockindex->nTx);

    if (blockindex->pprev)
        result.pushKV("previousblockhash", blockindex->pprev->GetBlockHash().GetHex());
    if (pnext)
        result.pushKV("nextblockhash", pnext->GetBlockHash().GetHex());
    return result;
    END
    q:to/END/,
    UniValue result = blockheaderToJSON(tip, blockindex);

    result.pushKV("strippedsize", (int)::GetSerializeSize(block, PROTOCOL_VERSION | SERIALIZE_TRANSACTION_NO_WITNESS));
    result.pushKV("size", (int)::GetSerializeSize(block, PROTOCOL_VERSION));
    result.pushKV("weight", (int)::GetBlockWeight(block));
    UniValue txs(UniValue::VARR);

    switch (verbosity) {
        case TxVerbosity::SHOW_TXID:
            for (const CTransactionRef& tx : block.vtx) {
                txs.push_back(tx->GetHash().GetHex());
            }
            break;

        case TxVerbosity::SHOW_DETAILS:
        case TxVerbosity::SHOW_DETAILS_AND_PREVOUT:
            CBlockUndo blockUndo;
            const bool have_undo = !IsBlockPruned(blockindex) && UndoReadFromDisk(blockUndo, blockindex);

            for (size_t i = 0; i < block.vtx.size(); ++i) {
                const CTransactionRef& tx = block.vtx.at(i);
                // coinbase transaction (i.e. i == 0) doesn't have undo data
                const CTxUndo* txundo = (have_undo && i > 0) ? &blockUndo.vtxundo.at(i - 1) : nullptr;
                UniValue objTx(UniValue::VOBJ);
                TxToUniv(*tx, uint256(), objTx, true, RPCSerializationFlags(), txundo, verbosity);
                txs.push_back(objTx);
            }
    }

    result.pushKV("tx", txs);

    return result;
    END
    q:to/END/,
    return RPCHelpMan{"getblockcount",
                "\nReturns the height of the most-work fully-validated chain.\n"
                "The genesis block has height 0.\n",
                {},
                RPCResult{
                    RPCResult::Type::NUM, "", "The current block count"},
                RPCExamples{
                    HelpExampleCli("getblockcount", "")
            + HelpExampleRpc("getblockcount", "")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            ChainstateManager& chainman = EnsureAnyChainman(request.context);
            LOCK(cs_main);
            return chainman.ActiveChain().Height();
        },
    };
    END
    q:to/END/,
    return RPCHelpMan{"getbestblockhash",
                "\nReturns the hash of the best (tip) block in the most-work fully-validated chain.\n",
                {},
                RPCResult{
                    RPCResult::Type::STR_HEX, "", "the block hash, hex-encoded"},
                RPCExamples{
                    HelpExampleCli("getbestblockhash", "")
            + HelpExampleRpc("getbestblockhash", "")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            ChainstateManager& chainman = EnsureAnyChainman(request.context);
            LOCK(cs_main);
            return chainman.ActiveChain().Tip()->GetBlockHash().GetHex();
        },
    };
    END
    q:to/END/,
    if(pindex) {
        LOCK(cs_blockchange);
        latestblock.hash = pindex->GetBlockHash();
        latestblock.height = pindex->nHeight;
    }
    cond_blockchange.notify_all();
    END
    q:to/END/,
    return RPCHelpMan{"syncwithvalidationinterfacequeue",
                "\nWaits for the validation interface queue to catch up on everything that was there when we entered this function.\n",
                {},
                RPCResult{RPCResult::Type::NONE, "", ""},
                RPCExamples{
                    HelpExampleCli("syncwithvalidationinterfacequeue","")
            + HelpExampleRpc("syncwithvalidationinterfacequeue","")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            SyncWithValidationInterfaceQueue();
            return NullUniValue;
        },
    };
    END
    q:to/END/,
    return RPCHelpMan{"getdifficulty",
                "\nReturns the proof-of-work difficulty as a multiple of the minimum difficulty.\n",
                {},
                RPCResult{
                    RPCResult::Type::NUM, "", "the proof-of-work difficulty as a multiple of the minimum difficulty."},
                RPCExamples{
                    HelpExampleCli("getdifficulty", "")
            + HelpExampleRpc("getdifficulty", "")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            ChainstateManager& chainman = EnsureAnyChainman(request.context);
            LOCK(cs_main);
            return GetDifficulty(chainman.ActiveChain().Tip());
        },
    };
    END
    q:to/END/,
    return {
        RPCResult{RPCResult::Type::NUM, "vsize", "virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted."},
        RPCResult{RPCResult::Type::NUM, "weight", "transaction weight as defined in BIP 141."},
        RPCResult{RPCResult::Type::STR_AMOUNT, "fee", "transaction fee in " + CURRENCY_UNIT + " (DEPRECATED)"},
        RPCResult{RPCResult::Type::STR_AMOUNT, "modifiedfee", "transaction fee with fee deltas used for mining priority (DEPRECATED)"},
        RPCResult{RPCResult::Type::NUM_TIME, "time", "local time transaction entered pool in seconds since 1 Jan 1970 GMT"},
        RPCResult{RPCResult::Type::NUM, "height", "block height when transaction entered pool"},
        RPCResult{RPCResult::Type::NUM, "descendantcount", "number of in-mempool descendant transactions (including this one)"},
        RPCResult{RPCResult::Type::NUM, "descendantsize", "virtual transaction size of in-mempool descendants (including this one)"},
        RPCResult{RPCResult::Type::STR_AMOUNT, "descendantfees", "modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)"},
        RPCResult{RPCResult::Type::NUM, "ancestorcount", "number of in-mempool ancestor transactions (including this one)"},
        RPCResult{RPCResult::Type::NUM, "ancestorsize", "virtual transaction size of in-mempool ancestors (including this one)"},
        RPCResult{RPCResult::Type::STR_AMOUNT, "ancestorfees", "modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)"},
        RPCResult{RPCResult::Type::STR_HEX, "wtxid", "hash of serialized transaction, including witness data"},
        RPCResult{RPCResult::Type::OBJ, "fees", "",
            {
                RPCResult{RPCResult::Type::STR_AMOUNT, "base", "transaction fee in " + CURRENCY_UNIT},
                RPCResult{RPCResult::Type::STR_AMOUNT, "modified", "transaction fee with fee deltas used for mining priority in " + CURRENCY_UNIT},
                RPCResult{RPCResult::Type::STR_AMOUNT, "ancestor", "modified fees (see above) of in-mempool ancestors (including this one) in " + CURRENCY_UNIT},
                RPCResult{RPCResult::Type::STR_AMOUNT, "descendant", "modified fees (see above) of in-mempool descendants (including this one) in " + CURRENCY_UNIT},
            }},
        RPCResult{RPCResult::Type::ARR, "depends", "unconfirmed transactions used as inputs for this transaction",
            {RPCResult{RPCResult::Type::STR_HEX, "transactionid", "parent transaction id"}}},
        RPCResult{RPCResult::Type::ARR, "spentby", "unconfirmed transactions spending outputs from this transaction",
            {RPCResult{RPCResult::Type::STR_HEX, "transactionid", "child transaction id"}}},
        RPCResult{RPCResult::Type::BOOL, "bip125-replaceable", "Whether this transaction could be replaced due to BIP125 (replace-by-fee)"},
        RPCResult{RPCResult::Type::BOOL, "unbroadcast", "Whether this transaction is currently unbroadcast (initial broadcast not yet acknowledged by any peers)"},
    };
    END
    q:to/END/,
    AssertLockHeld(pool.cs);

    UniValue fees(UniValue::VOBJ);
    fees.pushKV("base", ValueFromAmount(e.GetFee()));
    fees.pushKV("modified", ValueFromAmount(e.GetModifiedFee()));
    fees.pushKV("ancestor", ValueFromAmount(e.GetModFeesWithAncestors()));
    fees.pushKV("descendant", ValueFromAmount(e.GetModFeesWithDescendants()));
    info.pushKV("fees", fees);

    info.pushKV("vsize", (int)e.GetTxSize());
    info.pushKV("weight", (int)e.GetTxWeight());
    info.pushKV("fee", ValueFromAmount(e.GetFee()));
    info.pushKV("modifiedfee", ValueFromAmount(e.GetModifiedFee()));
    info.pushKV("time", count_seconds(e.GetTime()));
    info.pushKV("height", (int)e.GetHeight());
    info.pushKV("descendantcount", e.GetCountWithDescendants());
    info.pushKV("descendantsize", e.GetSizeWithDescendants());
    info.pushKV("descendantfees", e.GetModFeesWithDescendants());
    info.pushKV("ancestorcount", e.GetCountWithAncestors());
    info.pushKV("ancestorsize", e.GetSizeWithAncestors());
    info.pushKV("ancestorfees", e.GetModFeesWithAncestors());
    info.pushKV("wtxid", pool.vTxHashes[e.vTxHashesIdx].first.ToString());
    const CTransaction& tx = e.GetTx();
    std::set<std::string> setDepends;
    for (const CTxIn& txin : tx.vin)
    {
        if (pool.exists(GenTxid::Txid(txin.prevout.hash)))
            setDepends.insert(txin.prevout.hash.ToString());
    }

    UniValue depends(UniValue::VARR);
    for (const std::string& dep : setDepends)
    {
        depends.push_back(dep);
    }

    info.pushKV("depends", depends);

    UniValue spent(UniValue::VARR);
    const CTxMemPool::txiter& it = pool.mapTx.find(tx.GetHash());
    const CTxMemPoolEntry::Children& children = it->GetMemPoolChildrenConst();
    for (const CTxMemPoolEntry& child : children) {
        spent.push_back(child.GetTx().GetHash().ToString());
    }

    info.pushKV("spentby", spent);

    // Add opt-in RBF status
    bool rbfStatus = false;
    RBFTransactionState rbfState = IsRBFOptIn(tx, pool);
    if (rbfState == RBFTransactionState::UNKNOWN) {
        throw JSONRPCError(RPC_MISC_ERROR, "Transaction is not in mempool");
    } else if (rbfState == RBFTransactionState::REPLACEABLE_BIP125) {
        rbfStatus = true;
    }

    info.pushKV("bip125-replaceable", rbfStatus);
    info.pushKV("unbroadcast", pool.IsUnbroadcastTx(tx.GetHash()));
    END
    q:to/END/,
    if (verbose) {
        if (include_mempool_sequence) {
            throw JSONRPCError(RPC_INVALID_PARAMETER, "Verbose results cannot contain mempool sequence values.");
        }
        LOCK(pool.cs);
        UniValue o(UniValue::VOBJ);
        for (const CTxMemPoolEntry& e : pool.mapTx) {
            const uint256& hash = e.GetTx().GetHash();
            UniValue info(UniValue::VOBJ);
            entryToJSON(pool, info, e);
            // Mempool has unique entries so there is no advantage in using
            // UniValue::pushKV, which checks if the key already exists in O(N).
            // UniValue::__pushKV is used instead which currently is O(1).
            o.__pushKV(hash.ToString(), info);
        }
        return o;
    } else {
        uint64_t mempool_sequence;
        std::vector<uint256> vtxid;
        {
            LOCK(pool.cs);
            pool.queryHashes(vtxid);
            mempool_sequence = pool.GetSequence();
        }
        UniValue a(UniValue::VARR);
        for (const uint256& hash : vtxid)
            a.push_back(hash.ToString());

        if (!include_mempool_sequence) {
            return a;
        } else {
            UniValue o(UniValue::VOBJ);
            o.pushKV("txids", a);
            o.pushKV("mempool_sequence", mempool_sequence);
            return o;
        }
    }
    END
    q:to/END/,
    return RPCHelpMan{"getrawmempool",
                "\nReturns all transaction ids in memory pool as a json array of string transaction ids.\n"
                "\nHint: use getmempoolentry to fetch a specific transaction from the mempool.\n",
                {
                    {"verbose", RPCArg::Type::BOOL, RPCArg::Default{false}, "True for a json object, false for array of transaction ids"},
                    {"mempool_sequence", RPCArg::Type::BOOL, RPCArg::Default{false}, "If verbose=false, returns a json object with transaction list and mempool sequence number attached."},
                },
                {
                    RPCResult{"for verbose = false",
                        RPCResult::Type::ARR, "", "",
                        {
                            {RPCResult::Type::STR_HEX, "", "The transaction id"},
                        }},
                    RPCResult{"for verbose = true",
                        RPCResult::Type::OBJ_DYN, "", "",
                        {
                            {RPCResult::Type::OBJ, "transactionid", "", MempoolEntryDescription()},
                        }},
                    RPCResult{"for verbose = false and mempool_sequence = true",
                        RPCResult::Type::OBJ, "", "",
                        {
                            {RPCResult::Type::ARR, "txids", "",
                            {
                                {RPCResult::Type::STR_HEX, "", "The transaction id"},
                            }},
                            {RPCResult::Type::NUM, "mempool_sequence", "The mempool sequence value."},
                        }},
                },
                RPCExamples{
                    HelpExampleCli("getrawmempool", "true")
            + HelpExampleRpc("getrawmempool", "true")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            bool fVerbose = false;
            if (!request.params[0].isNull())
                fVerbose = request.params[0].get_bool();

            bool include_mempool_sequence = false;
            if (!request.params[1].isNull()) {
                include_mempool_sequence = request.params[1].get_bool();
            }

            return MempoolToJSON(EnsureAnyMemPool(request.context), fVerbose, include_mempool_sequence);
        },
    };
    END
    q:to/END/,

        return RPCHelpMan{"getmempoolancestors",
                "\nIf txid is in the mempool, returns all in-mempool ancestors.\n",
                {
                    {"txid", RPCArg::Type::STR_HEX, RPCArg::Optional::NO, "The transaction id (must be in mempool)"},
                    {"verbose", RPCArg::Type::BOOL, RPCArg::Default{false}, "True for a json object, false for array of transaction ids"},
                },
                {
                    RPCResult{"for verbose = false",
                        RPCResult::Type::ARR, "", "",
                        {{RPCResult::Type::STR_HEX, "", "The transaction id of an in-mempool ancestor transaction"}}},
                    RPCResult{"for verbose = true",
                        RPCResult::Type::OBJ_DYN, "", "",
                        {
                            {RPCResult::Type::OBJ, "transactionid", "", MempoolEntryDescription()},
                        }},
                },
                RPCExamples{
                    HelpExampleCli("getmempoolancestors", "\"mytxid\"")
            + HelpExampleRpc("getmempoolancestors", "\"mytxid\"")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            bool fVerbose = false;
            if (!request.params[1].isNull())
                fVerbose = request.params[1].get_bool();

            uint256 hash = ParseHashV(request.params[0], "parameter 1");

            const CTxMemPool& mempool = EnsureAnyMemPool(request.context);
            LOCK(mempool.cs);

            CTxMemPool::txiter it = mempool.mapTx.find(hash);
            if (it == mempool.mapTx.end()) {
                throw JSONRPCError(RPC_INVALID_ADDRESS_OR_KEY, "Transaction not in mempool");
            }

            CTxMemPool::setEntries setAncestors;
            uint64_t noLimit = std::numeric_limits<uint64_t>::max();
            std::string dummy;
            mempool.CalculateMemPoolAncestors(*it, setAncestors, noLimit, noLimit, noLimit, noLimit, dummy, false);

            if (!fVerbose) {
                UniValue o(UniValue::VARR);
                for (CTxMemPool::txiter ancestorIt : setAncestors) {
                    o.push_back(ancestorIt->GetTx().GetHash().ToString());
                }
                return o;
            } else {
                UniValue o(UniValue::VOBJ);
                for (CTxMemPool::txiter ancestorIt : setAncestors) {
                    const CTxMemPoolEntry &e = *ancestorIt;
                    const uint256& _hash = e.GetTx().GetHash();
                    UniValue info(UniValue::VOBJ);
                    entryToJSON(mempool, info, e);
                    o.pushKV(_hash.ToString(), info);
                }
                return o;
            }
        },
    };
    END
    q:to/END/,
    return RPCHelpMan{"getblockhash",
                "\nReturns hash of block in best-block-chain at height provided.\n",
                {
                    {"height", RPCArg::Type::NUM, RPCArg::Optional::NO, "The height index"},
                },
                RPCResult{
                    RPCResult::Type::STR_HEX, "", "The block hash"},
                RPCExamples{
                    HelpExampleCli("getblockhash", "1000")
            + HelpExampleRpc("getblockhash", "1000")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            ChainstateManager& chainman = EnsureAnyChainman(request.context);
            LOCK(cs_main);
            const CChain& active_chain = chainman.ActiveChain();

            int nHeight = request.params[0].get_int();
            if (nHeight < 0 || nHeight > active_chain.Height())
                throw JSONRPCError(RPC_INVALID_PARAMETER, "Block height out of range");

            CBlockIndex* pblockindex = active_chain[nHeight];
            return pblockindex->GetBlockHash().GetHex();
        },
    };
    END
    q:to/END/,
    CBlock block;
    if (IsBlockPruned(pblockindex)) {
        throw JSONRPCError(RPC_MISC_ERROR, "Block not available (pruned data)");
    }

    if (!ReadBlockFromDisk(block, pblockindex, Params().GetConsensus())) {
        // Block not found on disk. This could be because we have the block
        // header in our index but not yet have the block or did not accept the
        // block.
        throw JSONRPCError(RPC_MISC_ERROR, "Block not found on disk");
    }

    return block;
    END
    q:to/END/,
    return RPCHelpMan{"pruneblockchain", "",
                {
                    {"height", RPCArg::Type::NUM, RPCArg::Optional::NO, "The block height to prune up to. May be set to a discrete height, or to a " + UNIX_EPOCH_TIME + "\n"
            "                  to prune blocks whose block time is at least 2 hours older than the provided timestamp."},
                },
                RPCResult{
                    RPCResult::Type::NUM, "", "Height of the last block pruned"},
                RPCExamples{
                    HelpExampleCli("pruneblockchain", "1000")
            + HelpExampleRpc("pruneblockchain", "1000")
                },
        [&](const RPCHelpMan& self, const JSONRPCRequest& request) -> UniValue
        {
            if (!fPruneMode)
                throw JSONRPCError(RPC_MISC_ERROR, "Cannot prune blocks because node is not in prune mode.");

            ChainstateManager& chainman = EnsureAnyChainman(request.context);
            LOCK(cs_main);
            CChainState& active_chainstate = chainman.ActiveChainstate();
            CChain& active_chain = active_chainstate.m_chain;

            int heightParam = request.params[0].get_int();
            if (heightParam < 0)
                throw JSONRPCError(RPC_INVALID_PARAMETER, "Negative block height.");

            // Height value more than a billion is too high to be a block height, and
            // too low to be a block time (corresponds to timestamp from Sep 2001).
            if (heightParam > 1000000000) {
                // Add a 2 hour buffer to include blocks which might have had old timestamps
                CBlockIndex* pindex = active_chain.FindEarliestAtLeast(heightParam - TIMESTAMP_WINDOW, 0);
                if (!pindex) {
                    throw JSONRPCError(RPC_INVALID_PARAMETER, "Could not find block with at least the specified timestamp.");
                }
                heightParam = pindex->nHeight;
            }

            unsigned int height = (unsigned int) heightParam;
            unsigned int chainHeight = (unsigned int) active_chain.Height();
            if (chainHeight < Params().PruneAfterHeight())
                throw JSONRPCError(RPC_MISC_ERROR, "Blockchain is too short for pruning.");
            else if (height > chainHeight)
                throw JSONRPCError(RPC_INVALID_PARAMETER, "Blockchain is shorter than the attempted prune height.");
            else if (height > chainHeight - MIN_BLOCKS_TO_KEEP) {
                LogPrint(BCLog::RPC, "Attempt to prune blocks close to the tip.  Retaining the minimum number of blocks.\n");
                height = chainHeight - MIN_BLOCKS_TO_KEEP;
            }

            PruneBlockFilesManual(active_chainstate, height);
            const CBlockIndex* block = active_chain.Tip();
            CHECK_NONFATAL(block);
            while (block->pprev && (block->pprev->nStatus & BLOCK_HAVE_DATA)) {
                block = block->pprev;
            }
            return uint64_t(block->nHeight);
        },
    };
    END
    q:to/END/,
    if (hash_type_input == "hash_serialized_2") {
        return CoinStatsHashType::HASH_SERIALIZED;
    } else if (hash_type_input == "muhash") {
        return CoinStatsHashType::MUHASH;
    } else if (hash_type_input == "none") {
        return CoinStatsHashType::NONE;
    } else {
        throw JSONRPCError(RPC_INVALID_PARAMETER, strprintf("%s is not a valid hash_type", hash_type_input));
    }
    END

    q:to/END/,
    size_t count = 0;
    for (const auto& input : psbt.inputs) {
        if (!PSBTInputSigned(input)) {
            count++;
        }
    }

    return count;
    END
    q:to/END/,
    bool invalid;
    std::string tx_data = DecodeBase64(base64_tx, &invalid);
    if (invalid) {
        error = "invalid base64";
        return false;
    }
    return DecodeRawPSBT(psbt, tx_data, error);
    END
    q:to/END/,
    DataStream ss_data(MakeUCharSpan(tx_data), SER_NETWORK, PROTOCOL_VERSION);
    try {
        ss_data >> psbt;
        if (!ss_data.empty()) {
            error = "extra data after PSBT";
            return false;
        }
    } catch (const std::exception& e) {
        error = e.what();
        return false;
    }
    return true;
    END
    q:to/END/,
    // Finalize input signatures -- in case we have partial signatures that add up to a complete
    //   signature, but have not combined them yet (e.g. because the combiner that created this
    //   PartiallySignedTransaction did not understand them), this will combine them into a final
    //   script.
    bool complete = true;
    const PrecomputedTransactionData txdata = PrecomputePSBTData(psbtx);
    for (unsigned int i = 0; i < psbtx.tx->vin.size(); ++i) {
        complete &= SignPSBTInput(DUMMY_SIGNING_PROVIDER, psbtx, i, &txdata, SIGHASH_ALL);
    }

    return complete;
    END
    q:to/END/,
    // It's not safe to extract a PSBT that isn't finalized, and there's no easy way to check
    //   whether a PSBT is finalized without finalizing it, so we just do this.
    if (!FinalizePSBT(psbtx)) {
        return false;
    }

    result = *psbtx.tx;
    for (unsigned int i = 0; i < result.vin.size(); ++i) {
        result.vin[i].scriptSig = psbtx.inputs[i].final_script_sig;
        result.vin[i].scriptWitness = psbtx.inputs[i].final_script_witness;
    }
    return true;
    END
    q:to/END/,
    // Write the utxo
    if (non_witness_utxo) {
        SerializeToVector(s, PSBT_IN_NON_WITNESS_UTXO);
        OverrideStream<Stream> os(&s, s.GetType(), s.GetVersion() | SERIALIZE_TRANSACTION_NO_WITNESS);
        SerializeToVector(os, non_witness_utxo);
    }
    if (!witness_utxo.IsNull()) {
        SerializeToVector(s, PSBT_IN_WITNESS_UTXO);
        SerializeToVector(s, witness_utxo);
    }

    if (final_script_sig.empty() && final_script_witness.IsNull()) {
        // Write any partial signatures
        for (auto sig_pair : partial_sigs) {
            SerializeToVector(s, PSBT_IN_PARTIAL_SIG, MakeSpan(sig_pair.second.first));
            s << sig_pair.second.second;
        }

        // Write the sighash type
        if (sighash_type > 0) {
            SerializeToVector(s, PSBT_IN_SIGHASH);
            SerializeToVector(s, sighash_type);
        }

        // Write the redeem script
        if (!redeem_script.empty()) {
            SerializeToVector(s, PSBT_IN_REDEEMSCRIPT);
            s << redeem_script;
        }

        // Write the witness script
        if (!witness_script.empty()) {
            SerializeToVector(s, PSBT_IN_WITNESSSCRIPT);
            s << witness_script;
        }

        // Write any hd keypaths
        SerializeHDKeypaths(s, hd_keypaths, PSBT_IN_BIP32_DERIVATION);
    }

    // Write script sig
    if (!final_script_sig.empty()) {
        SerializeToVector(s, PSBT_IN_SCRIPTSIG);
        s << final_script_sig;
    }
    // write script witness
    if (!final_script_witness.IsNull()) {
        SerializeToVector(s, PSBT_IN_SCRIPTWITNESS);
        SerializeToVector(s, final_script_witness.stack);
    }

    // Write unknown things
    for (auto& entry : unknown) {
        s << entry.first;
        s << entry.second;
    }

    s << PSBT_SEPARATOR;
    END
    q:to/END/,
    // Used for duplicate key detection
    std::set<std::vector<unsigned char>> key_lookup;

    // Read loop
    bool found_sep = false;
    while(!s.empty()) {
        // Read
        std::vector<unsigned char> key;
        s >> key;

        // the key is empty if that was actually a separator byte
        // This is a special case for key lengths 0 as those are not allowed (except for separator)
        if (key.empty()) {
            found_sep = true;
            break;
        }

        // First byte of key is the type
        unsigned char type = key[0];

        // Do stuff based on type
        switch(type) {
            case PSBT_IN_NON_WITNESS_UTXO:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input non-witness utxo already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Non-witness utxo key is more than one byte type");
                }
                // Set the stream to unserialize with witness since this is always a valid network transaction
                OverrideStream<Stream> os(&s, s.GetType(), s.GetVersion() & ~SERIALIZE_TRANSACTION_NO_WITNESS);
                UnserializeFromVector(os, non_witness_utxo);
                break;
            }
            case PSBT_IN_WITNESS_UTXO:
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input witness utxo already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Witness utxo key is more than one byte type");
                }
                UnserializeFromVector(s, witness_utxo);
                break;
            case PSBT_IN_PARTIAL_SIG:
            {
                // Make sure that the key is the size of pubkey + 1
                if (key.size() != CPubKey::SIZE + 1 && key.size() != CPubKey::COMPRESSED_SIZE + 1) {
                    throw std::ios_base::failure("Size of key was not the expected size for the type partial signature pubkey");
                }
                // Read in the pubkey from key
                CPubKey pubkey(key.begin() + 1, key.end());
                if (!pubkey.IsFullyValid()) {
                   throw std::ios_base::failure("Invalid pubkey");
                }
                if (partial_sigs.count(pubkey.GetID()) > 0) {
                    throw std::ios_base::failure("Duplicate Key, input partial signature for pubkey already provided");
                }

                // Read in the signature from value
                std::vector<unsigned char> sig;
                s >> sig;

                // Add to list
                partial_sigs.emplace(pubkey.GetID(), SigPair(pubkey, std::move(sig)));
                break;
            }
            case PSBT_IN_SIGHASH:
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input sighash type already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Sighash type key is more than one byte type");
                }
                UnserializeFromVector(s, sighash_type);
                break;
            case PSBT_IN_REDEEMSCRIPT:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input redeemScript already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Input redeemScript key is more than one byte type");
                }
                s >> redeem_script;
                break;
            }
            case PSBT_IN_WITNESSSCRIPT:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input witnessScript already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Input witnessScript key is more than one byte type");
                }
                s >> witness_script;
                break;
            }
            case PSBT_IN_BIP32_DERIVATION:
            {
                DeserializeHDKeypaths(s, key, hd_keypaths);
                break;
            }
            case PSBT_IN_SCRIPTSIG:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input final scriptSig already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Final scriptSig key is more than one byte type");
                }
                s >> final_script_sig;
                break;
            }
            case PSBT_IN_SCRIPTWITNESS:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, input final scriptWitness already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Final scriptWitness key is more than one byte type");
                }
                UnserializeFromVector(s, final_script_witness.stack);
                break;
            }
            // Unknown stuff
            default:
                if (unknown.count(key) > 0) {
                    throw std::ios_base::failure("Duplicate Key, key for unknown value already provided");
                }
                // Read in the value
                std::vector<unsigned char> val_bytes;
                s >> val_bytes;
                unknown.emplace(std::move(key), std::move(val_bytes));
                break;
        }
    }

    if (!found_sep) {
        throw std::ios_base::failure("Separator is missing at the end of an input map");
    }

    END
    q:to/END/,
    if (!final_script_sig.empty()) {
        sigdata.scriptSig = final_script_sig;
        sigdata.complete = true;
    }
    if (!final_script_witness.IsNull()) {
        sigdata.scriptWitness = final_script_witness;
        sigdata.complete = true;
    }
    if (sigdata.complete) {
        return;
    }

    sigdata.signatures.insert(partial_sigs.begin(), partial_sigs.end());
    if (!redeem_script.empty()) {
        sigdata.redeem_script = redeem_script;
    }
    if (!witness_script.empty()) {
        sigdata.witness_script = witness_script;
    }
    for (const auto& key_pair : hd_keypaths) {
        sigdata.misc_pubkeys.emplace(key_pair.first.GetID(), key_pair);
    }
    END
    q:to/END/,
    if (sigdata.complete) {
        partial_sigs.clear();
        hd_keypaths.clear();
        redeem_script.clear();
        witness_script.clear();

        if (!sigdata.scriptSig.empty()) {
            final_script_sig = sigdata.scriptSig;
        }
        if (!sigdata.scriptWitness.IsNull()) {
            final_script_witness = sigdata.scriptWitness;
        }
        return;
    }

    partial_sigs.insert(sigdata.signatures.begin(), sigdata.signatures.end());
    if (redeem_script.empty() && !sigdata.redeem_script.empty()) {
        redeem_script = sigdata.redeem_script;
    }
    if (witness_script.empty() && !sigdata.witness_script.empty()) {
        witness_script = sigdata.witness_script;
    }
    for (const auto& entry : sigdata.misc_pubkeys) {
        hd_keypaths.emplace(entry.second);
    }
    END
    q:to/END/,
    if (!non_witness_utxo && input.non_witness_utxo) non_witness_utxo = input.non_witness_utxo;
    if (witness_utxo.IsNull() && !input.witness_utxo.IsNull()) {
        // TODO: For segwit v1, we will want to clear out the non-witness utxo when setting a witness one. For v0 and non-segwit, this is not safe
        witness_utxo = input.witness_utxo;
    }

    partial_sigs.insert(input.partial_sigs.begin(), input.partial_sigs.end());
    hd_keypaths.insert(input.hd_keypaths.begin(), input.hd_keypaths.end());
    unknown.insert(input.unknown.begin(), input.unknown.end());

    if (redeem_script.empty() && !input.redeem_script.empty()) redeem_script = input.redeem_script;
    if (witness_script.empty() && !input.witness_script.empty()) witness_script = input.witness_script;
    if (final_script_sig.empty() && !input.final_script_sig.empty()) final_script_sig = input.final_script_sig;
    if (final_script_witness.IsNull() && !input.final_script_witness.IsNull()) final_script_witness = input.final_script_witness;
    END
    q:to/END/,
    // Write the redeem script
    if (!redeem_script.empty()) {
        SerializeToVector(s, PSBT_OUT_REDEEMSCRIPT);
        s << redeem_script;
    }

    // Write the witness script
    if (!witness_script.empty()) {
        SerializeToVector(s, PSBT_OUT_WITNESSSCRIPT);
        s << witness_script;
    }

    // Write any hd keypaths
    SerializeHDKeypaths(s, hd_keypaths, PSBT_OUT_BIP32_DERIVATION);

    // Write unknown things
    for (auto& entry : unknown) {
        s << entry.first;
        s << entry.second;
    }

    s << PSBT_SEPARATOR;
    END
    q:to/END/,
    // Used for duplicate key detection
    std::set<std::vector<unsigned char>> key_lookup;

    // Read loop
    bool found_sep = false;
    while(!s.empty()) {
        // Read
        std::vector<unsigned char> key;
        s >> key;

        // the key is empty if that was actually a separator byte
        // This is a special case for key lengths 0 as those are not allowed (except for separator)
        if (key.empty()) {
            found_sep = true;
            break;
        }

        // First byte of key is the type
        unsigned char type = key[0];

        // Do stuff based on type
        switch(type) {
            case PSBT_OUT_REDEEMSCRIPT:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, output redeemScript already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Output redeemScript key is more than one byte type");
                }
                s >> redeem_script;
                break;
            }
            case PSBT_OUT_WITNESSSCRIPT:
            {
                if (!key_lookup.emplace(key).second) {
                    throw std::ios_base::failure("Duplicate Key, output witnessScript already provided");
                } else if (key.size() != 1) {
                    throw std::ios_base::failure("Output witnessScript key is more than one byte type");
                }
                s >> witness_script;
                break;
            }
            case PSBT_OUT_BIP32_DERIVATION:
            {
                DeserializeHDKeypaths(s, key, hd_keypaths);
                break;
            }
            // Unknown stuff
            default: {
                if (unknown.count(key) > 0) {
                    throw std::ios_base::failure("Duplicate Key, key for unknown value already provided");
                }
                // Read in the value
                std::vector<unsigned char> val_bytes;
                s >> val_bytes;
                unknown.emplace(std::move(key), std::move(val_bytes));
                break;
            }
        }
    }

    if (!found_sep) {
        throw std::ios_base::failure("Separator is missing at the end of an output map");
    }
    END
    q:to/END/,
    if (!redeem_script.empty()) {
        sigdata.redeem_script = redeem_script;
    }
    if (!witness_script.empty()) {
        sigdata.witness_script = witness_script;
    }
    for (const auto& key_pair : hd_keypaths) {
        sigdata.misc_pubkeys.emplace(key_pair.first.GetID(), key_pair);
    }
    END
    q:to/END/,
    if (redeem_script.empty() && !sigdata.redeem_script.empty()) {
        redeem_script = sigdata.redeem_script;
    }
    if (witness_script.empty() && !sigdata.witness_script.empty()) {
        witness_script = sigdata.witness_script;
    }
    for (const auto& entry : sigdata.misc_pubkeys) {
        hd_keypaths.emplace(entry.second);
    }
    END
    q:to/END/,
    hd_keypaths.insert(output.hd_keypaths.begin(), output.hd_keypaths.end());
    unknown.insert(output.unknown.begin(), output.unknown.end());

    if (redeem_script.empty() && !output.redeem_script.empty()) redeem_script = output.redeem_script;
    if (witness_script.empty() && !output.witness_script.empty()) witness_script = output.witness_script;
    // Prohibited to merge two PSBTs over different transactions
    if (tx->GetHash() != psbt.tx->GetHash()) {
        return false;
    }

    for (unsigned int i = 0; i < inputs.size(); ++i) {
        inputs[i].Merge(psbt.inputs[i]);
    }
    for (unsigned int i = 0; i < outputs.size(); ++i) {
        outputs[i].Merge(psbt.outputs[i]);
    }
    unknown.insert(psbt.unknown.begin(), psbt.unknown.end());

    return true;
    END
    q:to/END/,
    if (std::find(tx->vin.begin(), tx->vin.end(), txin) != tx->vin.end()) {
        return false;
    }
    tx->vin.push_back(txin);
    psbtin.partial_sigs.clear();
    psbtin.final_script_sig.clear();
    psbtin.final_script_witness.SetNull();
    inputs.push_back(psbtin);
    return true;
    END
    q:to/END/,
    tx->vout.push_back(txout);
    outputs.push_back(psbtout);
    return true;
    END
    q:to/END/,
    const PSBTInput& input = inputs[input_index];
    uint32_t prevout_index = tx->vin[input_index].prevout.n;
    if (input.non_witness_utxo) {
        if (prevout_index >= input.non_witness_utxo->vout.size()) {
            return false;
        }
        if (input.non_witness_utxo->GetHash() != tx->vin[input_index].prevout.hash) {
            return false;
        }
        utxo = input.non_witness_utxo->vout[prevout_index];
    } else if (!input.witness_utxo.IsNull()) {
        utxo = input.witness_utxo;
    } else {
        return false;
    }
    return true;
    END
    q:to/END/,
    switch (role) {
    case PSBTRole::CREATOR: return "creator";
    case PSBTRole::UPDATER: return "updater";
    case PSBTRole::SIGNER: return "signer";
    case PSBTRole::FINALIZER: return "finalizer";
    case PSBTRole::EXTRACTOR: return "extractor";
        // no default case, so the compiler can warn about missing cases
    }
    assert(false);
    END
    q:to/END/,
    PSBTInput& input = psbt.inputs.at(index);
    const CMutableTransaction& tx = *psbt.tx;

    if (PSBTInputSigned(input)) {
        return true;
    }

    // Fill SignatureData with input info
    SignatureData sigdata;
    input.FillSignatureData(sigdata);

    // Get UTXO
    bool require_witness_sig = false;
    CTxOut utxo;

    if (input.non_witness_utxo) {
        // If we're taking our information from a non-witness UTXO, verify that it matches the prevout.
        OutPoint prevout = tx.vin[index].prevout;
        if (prevout.n >= input.non_witness_utxo->vout.size()) {
            return false;
        }
        if (input.non_witness_utxo->GetHash() != prevout.hash) {
            return false;
        }
        utxo = input.non_witness_utxo->vout[prevout.n];
    } else if (!input.witness_utxo.IsNull()) {
        utxo = input.witness_utxo;
        // When we're taking our information from a witness UTXO, we can't verify it is actually data from
        // the output being spent. This is safe in case a witness signature is produced (which includes this
        // information directly in the hash), but not for non-witness signatures. Remember that we require
        // a witness signature in this situation.
        require_witness_sig = true;
    } else {
        return false;
    }

    sigdata.witness = false;
    bool sig_complete;
    if (txdata == nullptr) {
        sig_complete = ProduceSignature(provider, DUMMY_SIGNATURE_CREATOR, utxo.scriptPubKey, sigdata);
    } else {
        MutableTransactionSignatureCreator creator(&tx, index, utxo.nValue, txdata, sighash);
        sig_complete = ProduceSignature(provider, creator, utxo.scriptPubKey, sigdata);
    }
    // Verify that a witness signature was produced in case one was required.
    if (require_witness_sig && !sigdata.witness) return false;
    input.FromSignatureData(sigdata);

    // If we have a witness signature, put a witness UTXO.
    // TODO: For segwit v1, we should remove the non_witness_utxo
    if (sigdata.witness) {
        input.witness_utxo = utxo;
        // input.non_witness_utxo = nullptr;
    }

    // Fill in the missing info
    if (out_sigdata) {
        out_sigdata->missing_pubkeys = sigdata.missing_pubkeys;
        out_sigdata->missing_sigs = sigdata.missing_sigs;
        out_sigdata->missing_redeem_script = sigdata.missing_redeem_script;
        out_sigdata->missing_witness_script = sigdata.missing_witness_script;
    }

    return sig_complete;
    END

];

sub run($in) {
    my $res = G.parse($in) // do { say $in; False };
    ok so $res;
}

sub test-all {
    plan @inputs.elems;
    for @inputs {
        run($_);
    }
}

sub test-some($n) {

    plan $n + 1;

    for 0..$n {
        run(@inputs[$_]);
    }
}

test-some(20);
