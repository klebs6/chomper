
            // add services
            (*p_info).address.n_services = ServiceFlags((*p_info).address.n_services | addr.n_services);

            // do not update if no new information is present
            if (!addr.n_time || (p_info->n_time && addr.n_time <= p_info->n_time))
                return false;

            // do not update if the entry was already in the "tried" table
            if (p_info->fInTried)
                return false;

            // do not update if the max reference count is reached
            if (p_info->nRefCount == ADDRMAN_NEW_BUCKETS_PER_ADDRESS)
                return false;

            // stochastic test: previous nRefCount == N: 2^N times harder to increase it
            int nFactor = 1;
            for (int n = 0; n < p_info->nRefCount; n++)
                nFactor *= 2;
            if (nFactor > 1 && (insecure_rand.randrange(nFactor) != 0))
                return false;
