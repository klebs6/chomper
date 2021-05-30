our %typemap = 
%(
    #'const_iterator' => '*const TraceEvent',

    #from USD
    'Byte'                              => 'u8',
    'qboolean'                          => 'bool',
    '_PerThreadData'                    => 'TraceCollectorPerThreadData',
    'JsWriter'                          => 'serde_json::Serializer',
    'GfRect2i'                          => 'Rect2i',
    'DWORD'                             => 'u64',
    'uintptr_t'                         => 'libc::uintptr_t',
    'mach_header'                       => 'MachHeader',
    'TfRefCount'                        => 'RefCount',
    'int64_t'                           => 'i64',
    'GfVec4i'                           => 'Vec4i',
    'FILE'                              => 'libc::FILE',
    'value_type'                        => 'T',
    'TfDiagnosticInfo'                  => 'DiagnosticInfo',
    '_PathNodeTableType'                => 'malloc_global_data::PathNodeTableType',
    'TfWeakBase'                        => 'WeakBase',
    'tbb::task_group'                   => 'taskwait::TaskGroup',
    'ErrorIterator'                     => 'diagnostic_mgr::ErrorIterator',
    '_SeenPlugins'                      => 'PlugPluginSeenPlugins',
    'Tf_MallocCallSiteTable'            => 'MallocCallSiteTable',
    'short'                             => 'i16',
    'DoubleToStringConverter::DtoaMode' => 'DoubleToStringConverterDtoaMode',
    'time_t'                            => 'libc::time_t',
    'TfToken'                           => 'Token',
    'std::ostream'                      => 'std::io::BufWriter',
    'ostream'                           => 'std::io::BufWriter',
    'std::istream'                      => 'std::io::BufReader',
    'istream'                           => 'std::io::BufReader',
    'GfRange1f'                         => 'Range1f',
    'TfWalkErrorHandler'                => 'WalkErrorHandler',
    'GfBBox3d'                          => 'BBox3D',
    'TfScriptModuleLoader'              => 'ScriptModuleLoader',
    'GfQuatd'                           => 'Quatd',
    '_MallocStackData'                  => 'MallocStackData',
    'TfScopeDescription'                => 'ScopeDescription',
    'GfRange3f'                         => 'Range3f',
    'intptr_t'                          => 'libc::intptr_t',
    'uc16'                              => 'u16',
    'GfMatrix3f'                        => 'Matrix3f',
    'std::type_info'                    => 'type_info::TypeId',
    '_CallStackTableType'               => 'malloc_global_data::CallStackTableType',
    'uint32_t'                          => 'u32',
    '_Node'                             => 'DebugNode',
    'GfMultiInterval'                   => 'MultiInterval',
    'TfWalkFunction'                    => 'WalkFunction',
    'GfLineSeg2d'                       => 'LineSegment2D',
    'unsigned long long'                => 'u64',
    'std::regex'                        => 'regex::Regex',
    'CallTree'                          => 'malloc_tag::CallTree',
    'Keys'                              => 'notice::Keys',
    'TfStopwatch'                       => 'Stopwatch',
    'GfFrustum'                         => 'Frustum',
    'GfVec2f'                           => 'Vec2f',
    'GfVec2d'                           => 'Vec2d',
    'StatusHelper'                      => 'diagnostic_mgr::StatusHelper',
    'Vector<char>'                      => 'Vector<libc::c_schar>',
    'CallSite'                          => 'malloc_tag::call_tree::CallSite',
    'tbb::spin_mutex'                   => 'SpinMutex',
    'GfVec2h'                           => 'Vec2h',
    'unsigned short'                    => 'u16',
    '_Stack'                            => 'Stack',
    'MallocTagCallTree'                 => 'malloc_tag::CallTree',
    '_Bound'                            => 'Bound',
    'GfMatrix2d'                        => 'Matrix2d',
    'Tf_NoticeRegistry'                 => 'NoticeRegistry',
    'std::thread::id'                   => 'std::thread::ThreadId',
    'void'                              => 'c_void',
    'Tf_MallocPathNode'                 => 'MallocPathNode',
    'uint64_t'                          => 'u64',
    'unsigned'                          => 'u32',
    'TypeVector'                        => 'Vec<Type>',
    'DoubleToStringConverter'           => 'DoubleToStringConverterDtoaMode',
    'GfRotation'                        => 'Rotation',
    '_TypeInfo'                         => 'TypeInfo',
    'Tf_EnvSettingRegistry'             => 'EnvSettingRegistry',
    'WarningHelper'                     => 'diagnostic_mgr::WarningHelper',
    '_DelivererContainer'               => 'DelivererContainer',
    'uint32'                            => 'u32',
    'GfVec4f'                           => 'Vec4f',
    'GfVec3d'                           => 'Vec3d',
    'TfEnum'                            => 'Enum',
    'GfQuath'                           => 'Quath',
    'ErrorHelper'                       => 'diagnostic_mgr::ErrorHelper',
    'type_info'                         => 'type_info::TypeId',
    'GfQuatf'                           => 'Quatf',
    'Key'                               => 'notice::Key',
    'TfDiagnosticMgr'                   => 'DiagnosticMgr',
    'GfVec4h'                           => 'Vec4h',
    'TfToken::HashSet'                  => 'token::HashSet',
    'GfVec3i'                           => 'Vec3i',
    'CallStackInfo'                     => 'malloc_tag::CallStackInfo',
    'uint16_t'                          => 'u16',
    'TfStatus'                          => 'Status',
    'GfVec3f'                           => 'Vec3f',
    'TfNotice'                          => 'Notice',
    'atomic<bool>'                      => 'AtomicBool',
    'DtoaMode'                          => 'DoubleToStringConverterDtoaMode',
    '_CastFunction'                     => 'TypeCastFunction',
    'GfRange1d'                         => 'Range1d',
    'GfRange3d'                         => 'Range3d',
    '_ImmortalTag'                      => 'ImmortalTag',
    '_Rep'                              => 'TokenRep',
    'GfVec2i'                           => 'Vec2i',
    '_Entry'                            => 'TypeInfoMapEntry',
    'FOVDirection'                      => 'CameraFOVDirection',
    'unsigned char'                     => 'libc::u_char',
    'GfPlane'                           => 'Plane',
    'PathNode'                          => 'malloc_tag::call_tree::PathNode',
    'Vector<const char>'                => 'Vector<libc::c_schar>',
    'TfSmallVector'                     => 'SmallVector',
    'Tf_FileIdSet'                      => 'FileIdSet',
    'GfSize3'                           => 'Size3',
    'GfVec1i'                           => 'Vec1i',
    'size_t'                            => 'libc::size_t',
    'Tf_TypeRegistry'                   => 'TypeRegistry',
    'TfError'                           => 'Error',
    '_DelivererListEntry'               => 'DelivererListEntry',
    'TfWarning'                         => 'Warning',
    'TfTemplateString'                  => 'TemplateString',
    'Arch_ProgInfo'                     => 'ArchProgInfo',
    'GfVec3h'                           => 'Vec3h',
    'GfHalf'                            => 'Half',
    'TfErrorTransport'                  => 'ErrorTransport',
    'TfRegistryManager'                 => 'RegistryManager',
    'GfMatrix4f'                        => 'Matrix4f',
    'stat'                              => 'libc::stat',
    'GfVec1h'                           => 'Vec1h',
    '_DelivererWeakPtr'                 => 'DelivererWeakPtr',
    'GfSize2'                           => 'Size2',
    'TfErrorMark'                       => 'ErrorMark',
    'half'                              => 'Half',
    'JsValue'                           => 'serde_json::value::Value',
    'JsArray'                           => 'serde_json::value::Value',
    'string'                            => 'String',
    'Tf_TokenRegistry'                  => 'TokenRegistry',
    'long'                              => 'i64',
    'GfLineSeg'                         => 'LineSegment',
    'unsigned int'                      => 'u32',
    'Arch_LogInfo'                      => 'ArchLogInfo',
    'GfVec1f'                           => 'Vec1f',
    'TfDiagnosticBase'                  => 'DiagnosticBase',
    '_Tagging'                          => 'malloc_tag::Tagging',
    'GfVec4d'                           => 'Vec4d',
    'set<string>'                       => 'HashSet<String>',
    'Tf_FileId'                         => 'FileId',
    'GfMatrix4d'                        => 'Matrix4d',
    'TfType'                            => 'Type',
    'char'                              => 'libc::c_schar',
    'GfInterval'                        => 'Interval',
    'Projection'                        => 'CameraProjection',
    'TfPointerAndBits'                  => 'PointerAndBits',
    'TfCallContext'                     => 'CallContext',
    'GfLine2d'                          => 'Line2d',
    'GfQuaternion'                      => 'Quaternion',
    'uint64'                            => 'u64',
    'double'                            => 'f64',
    'Tf_MallocBlockInfo'                => 'MallocBlockInfo',
    'int'                               => 'i32',
    'int16_t'                           => 'i16',
    'TfDebug::_Node'                    => 'DebugNode',
    'GfLine'                            => 'Line',
    'std::atomic<bool>'                 => 'AtomicBool',
    'int32_t'                           => 'i32',
    'siginfo_t'                         => 'libc::siginfo_t',
    'Tf_MallocTagStringMatchTable'      => 'MallocTagStringMatchTable',
    'TfRegTest'                         => 'RegTest',
    '_LogText'                          => 'diagnostic_mgr::LogText',
    'Tf_MalocGlobalData'                => 'MallocGlobalData',
    'GfMatrix3d'                        => 'Matrix3d',
    '_StackRegistry'                    => 'StackRegistry',
    'tbb::spin_mutex::scoped_lock'      => 'std::sync::MutexGuard',
    'Tf_MallocCallSite'                 => 'MallocCallSite',
    '_RepPtrAndBits'                    => 'TokenRegistryRepPtrAndBits',
    'unsigned long'                     => 'u64',
    'GfRay'                             => 'Ray',
    'GfTransform'                       => 'Transform',
    '_RepPtr'                           => 'TokenRegistryRepPtr',
    'GfRange2d'                         => 'Range2d',
    'float'                             => 'f32',
    'Tf_RegistryManagerImpl'            => 'RegistryManagerImpl',
    'This'                              => 'diagnostic_mgr::This',
    'std::string'                       => 'String',
    'GfRange2f'                         => 'Range2f',
    'GfVec1d'                           => 'Vec1d',
    'TfDiagnosticType'                  => 'DiagnosticType',
    'GfMatrix2f'                        => 'Matrix2f',
    'JsObject'                          => 'serde_json::value::Value',
    '_ControlBlock'                     => 'Vt_ArrayBaseControlBlock',

    #from Quake
    'BOOL'                            => "bool",
    'ControllerModulationSource'      => 'ControllerModulationSource',
    'DIR'                             => 'Dir',
    'FILE'                            => 'libc::FILE',
    'FLAC_SIZE_T'                     => 'FLAC_SIZE_T',
    'FLAC__Frame'                     => 'FLAC__Frame',
    'FLAC__StreamDecoder'             => 'FLAC__StreamDecoder',
    'FLAC__StreamDecoderErrorStatus'  => 'FLAC__StreamDecoderErrorStatus',
    'FLAC__StreamDecoderLengthStatus' => 'FLAC__StreamDecoderLengthStatus',
    'FLAC__StreamDecoderReadStatus'   => 'FLAC__StreamDecoderReadStatus',
    'FLAC__StreamDecoderSeekStatus'   => 'FLAC__StreamDecoderSeekStatus',
    'FLAC__StreamDecoderTellStatus'   => 'FLAC__StreamDecoderTellStatus',
    'FLAC__StreamDecoderWriteStatus'  => 'FLAC__StreamDecoderWriteStatus',
    'FLAC__StreamMetadata'            => 'FLAC__StreamMetadata',
    'FLAC__bool'                      => 'FLAC__bool',
    'FLAC__byte'                      => 'FLAC__byte',
    'FLAC__int32'                     => 'FLAC__int32',
    'FLAC__int64'                     => 'FLAC__int64',
    'FLAC__uint64'                    => 'FLAC__uint64',
    'KeyboardMapping'                 => 'KeyboardMapping',
    'MREADER'                         => 'MReader',
    'ModulationRouting'               => 'ModulationRouting',
    'OscillatorStorage'               => 'OscillatorStorage',
    'PluginLayer'                     => 'PluginLayer',
    'PollProcedure'                   => 'PollProcedure',
    'QuadFilterChainState'            => 'QuadFilterChainState',
    'SDL_DisplayMode'                 => 'SDL_DisplayMode',
    'SDL_Event'                       => 'SdlEvent',
    'SDL_GameControllerButton'        => 'SDL_GameControllerButton',
    'SDL_Scancode'                    => 'SDL_Scancode',
    'Scale'                           => 'Scale',
    'SurgeVoice'                      => 'SurgeVoice',
    'Uint32'                          => 'u32',
    'Uint8'                           => 'u8',
    'VkBool32'                        => 'vk::Bool32',
    'VkBuffer'                        => 'vk::Buffer',
    'VkCommandBuffer'                 => 'vk::CommandBuffer',
    'VkDebugReportFlagsEXT'           => 'vk::DebugReportFlagsEXT',
    'VkDebugReportObjectTypeEXT'      => 'vk::DebugReportObjectTypeEXT',
    'VkDescriptorSet'                 => 'vk::DescriptorSet',
    'VkDeviceMemory'                  => 'vk::DeviceMemory',
    'VkDeviceSize'                    => 'vk::DeviceSize',
    'VkFlags'                         => 'vk::Flags',
    'VkPipelineBindPoint'             => 'vk::PipelineBindPoint',
    'VkResult'                        => 'vk::Result',
    'VkShaderModule'                  => 'vk::ShaderModule',
    'VkShaderStageFlags'              => 'vk::ShaderStageFlags',
    'Wavetable'                       => 'WaveTable',
    'Wavetable'                       => 'Wavetable',
    '__m128'                          => '__m128',
    '__m128i'                         => '__m128i',
    '__m64'                           => '__m64',
    'aliashdr_t'                      => 'AliasHDR',
    'basicvertex_t'                   => 'BasicVertex',
    'beam_t'                          => 'Beam',
    'bool'                            => "bool",
    'buffer_garbage_t'                => 'BufferGarbage',
    'byte'                            => 'u8',
    'cache_user_t'                    => 'cache_user_t',
    'canvastype'                      => 'CanvasType',
    'channel_t'                       => 'Channel',
    'char'                            => 'u8',
    'client_t'                        => 'QuakeClient',
    'cmd_function_t'                  => 'CmdFunction',
    'cmd_source_t'                    => 'CommandSource',
    'cmdalias_t'                      => 'CmdAlias',
    'cvar_t'                          => 'CVar',
    'cvarcallback_t'                  => 'CVarCallback',
    'daliasskintype_t'                => 'DAliasSkinType',
    'ddef_t'                          => 'DDef',
    'dfunction_t'                     => 'DFunction',
    'dirent'                          => 'DirEnt',
    'dl1leaf_t'                       => 'DL1Leaf',
    'dl1node_t'                       => 'DL1Node',
    'dl2leaf_t'                       => 'DL2Leaf',
    'dlight_t'                        => 'DLight',
    'dma_t'                           => 'Dma',
    'double'                          => 'f64',
    'dsleaf_t'                        => 'DSLeaf',
    'dstatement_t'                    => 'DStatement',
    'dynbuffer_t'                     => 'DynBuffer',
    'edict_t'                         => 'EDict',
    'efrag_t'                         => 'EFrag',
    'entity_t'                        => 'Entity',
    'enum srcformat'                  => 'SrcFormat',
    'eval_t'                          => 'EVal',
    'f32'                             => "f32",
    'f64'                             => "f64",
    'fci_t'                           => 'FCompactIndex',
    'fd_set'                          => 'libc::fd_set',
    'filelist_item_t'                 => 'FileListItem',
    'filter_t'                        => 'Filter',
    'fixed16_t'                       => 'i32',
    'float'                           => '&mut f32',
    'float'                           => 'f32',
    'fshandle_t'                      => 'FsHandle',
    'func_t'                          => 'Func',
    'glRect_t'                        => 'GLRect',
    'glheap_t'                        => 'GLHeap',
    'glheapnode_t'                    => 'GLHeapNode',
    'glpoly_t'                        => 'GLPoly',
    'gltexture_t'                     => 'GLTexture',
    'i16'                             => "i16",
    'i32'                             => "i32",
    'i64'                             => "i64",
    'i8'                              => "i8",
    'int'                             => '*i32',
    'int'                             => 'i32',
    'int32_t'                         => 'i32',
    'int64_t'                         => 'i64',
    'joyaxis_t'                       => 'JoyAxis',
    'kbutton_t'                       => 'KButton',
    'lerpdata_t'                      => 'LerpData',
    'link_t'                          => 'Link',
    'long'                            => 'i64',
    'lump_t'                          => 'Lump',
    'lumpinfo_t'                      => 'LumpInfo',
    'maliasframedesc_t'               => 'MAliasFrameDesc',
    'medge_t'                         => 'Edge',
    'mleaf_t'                         => 'MLeaf',
    'mnode_t'                         => 'MNode',
    'modsources'                      => "ModSource",
    'mplane_t'                        => 'MPlane',
    'mspriteframe_t'                  => 'SpriteFrame',
    'dspriteframe_t'                  => 'SpriteFrame',
    'msurface_t'                      => 'MSurface',
    'mtexinfo_t'                      => 'MTexInfo',
    'texinfo_t'                       => 'TexInfo',
    'mtriangle_t'                     => 'Triangle',
    'mvertex_t'                       => 'MVertex',
    'dvertex_t'                       => 'DVertex',
    'off_t'                           => 'libc::ptrdiff_t',
    'ogg_int64_t'                     => 'i64',
    'opus_int64'                      => 'i64',
    'pack_t'                          => 'Pack',
    'parametermeta'                   => '&mut ParamRTMeta',
    'passwd'                          => 'libc::passwd',
    'plane_t'                         => 'Plane',
    'qboolean'                        => 'bool',
    'qmodel_t'                        => 'QModel',
    'qpic_t'                          => 'QPic',
    'qsockaddr'                       => 'QSockAddr',
    'qsocket_s'                       => 'QSocket',
    'qsocket_t'                       => 'QSocket',
    'quakeparms_t'                    => 'QuakeParams',
    'scoreboard_t'                    => 'ScoreBoard',
    'searchpath_t'                    => 'SearchPath',
    'sfx_t'                           => 'Sfx',
    'sfxcache_t'                      => 'SfxCache',
    'short'                           => '*i16',
    'short'                           => 'i16',
    'size_t'                          => 'usize',
    'sizebuf_t'                       => 'SizeBuf',
    'snd_codec_t'                     => 'SndCodec',
    'snd_info_t'                      => 'SndInfo',
    'snd_stream_t'                    => 'SndStream',
    'src_offset_t'                    => 'src_offset_t',
    'ssize_t'                         => 'isize',
    'stbi__write_context'             => 'StbiWriteContext',
    'stbi_write_func'                 => 'StbiWriteFunc',
    'std::string'                     => 'String',
    'stdio_buffer_t'                  => 'StdioBuffer',
    'string'                          => 'String',
    'string_t'                        => 'String',
    'struct cache_user_s'             => 'CacheUser',
    'struct qsockaddr'                => 'QSockAddr',
    'struct qsocket_s'                => 'QSocket',
    'struct texture_s'                => 'Texture',
    'struct upkg_hdr'                 => 'UpkgHdr',
    'sys_socket_t'                    => 'SysSocket',
    'texchain_t'                      => 'TexChain',
    'texture_t'                       => 'Texture',
    'timeval'                         => 'libc::timeval',
    'trace_t'                         => 'Trace',
    'u16'                             => "u16",
    'u32'                             => "u32",
    'u64'                             => "u64",
    'u8'                              => "u8",
    'uint32_t'                        => 'u32',
    'uint64_t'                        => 'u64',
    'unsigned char'                   => 'u8',
    'unsigned int'                    => 'u32',
    'unsigned short'                  => 'u16',
    'unsigned'                        => 'u32',
    'usercmd_t'                       => 'UserCmd',
    'vFloat'                          => "vFloat",
    'vec3_t'                          => 'Vec3::<f32>',
    'vec_t'                           => 'f32',
    'void'                            => 'libc::c_void',
    'vrect_t'                         => 'VRect',
    'vulkan_desc_set_layout_t'        => 'VulkanDescSetLayout',
    'vulkan_pipeline_t'               => 'VulkanPipeline',
    'wavinfo_t'                       => 'WavInfo',
    'wchar_t'                         => 'libc::wchar_t',
    'wt_header'                       => 'WaveTableHeader',
    'xcommand_t'                      => 'XCommand',
    'trivertx_t'                      => 'TriVertex',
    'aliasmesh_t'                     => 'AliasMesh',
    'floodfill_t'                     => 'FloodFill',
    'dspritegroup_t'                  => 'SpriteGroup',
    'mspritegroup_t'                  => 'ModelGenSpriteGroup',
    'dspriteinterval_t'               => 'SpriteInterval',
    'daliasskingroup_t'               => 'AliasSkinGroup',
    'daliasskininterval_t'            => 'AliasSkinInterval',
    'texture_garbage_t'               => 'TextureGarbage',
    'pcxheader_t'                     => 'PCXHeader',
    'SDL_GameController'              => 'SDL_GameController',
    'dmiptexlump_t'                   => 'DMipTexLump',
    'miptex_t'                        => 'MipTex',
    'dmodel_t'                        => 'DModel',
    'dplane_t'                        => 'DPlane',
    'mplane_t'                        => 'MPlane',
    'dsclipnode_t'                    => 'DSClipNode',
    'dlclipnode_t'                    => 'DLClipNode',
    'mclipnode_t'                     => 'MClipNode',
    'hull_t'                          => 'Hull',
    'msurface_t'                      => 'MSurface',
    'dsface_t'                        => 'DSFace',
    'dlface_t'                        => 'DLFace',
    'dl2node_t'                       => 'DL2Node',
    'dsnode_t'                        => 'DSNode',

    #From Zircon
    'ACPI_STATUS'            => 'acpi::Status',
    'ACPI_SIZE'              => 'acpi::Size',
    'ACPI_EXECUTE_TYPE'      => 'acpi::ExecuteType',
    'ACPI_OSD_EXEC_CALLBACK' => 'acpi::OsdExecCallback',
    'ACPI_OSD_HANDLER'       => 'acpi::OsdHandler',
    'ACPI_THREAD_ID'         => 'acpi::ThreadId',
    'ACPI_CACHE_T'           => 'acpi::Cache',
    'ACPI_STRING'            => 'acpi::String',
    'ACPI_PREDEFINED_NAMES'  => 'acpi::PredefinedNames',
    'ACPI_TABLE_HEADER'      => 'acpi::TableHeader',
    'ACPI_PHYSICAL_ADDRESS'  => 'acpi::PhysicalAddress',
    'ACPI_SEMAPHORE'         => 'acpi::Semaphore',
    'ACPI_MUTEX'             => 'acpi::Mutex',
    'ACPI_SPINLOCK'          => 'acpi::SpinLock',
    'ACPI_CPU_FLAGS'         => 'acpi::CpuFlags',
    'ACPI_PCI_ID'            => 'acpi::PCIId',
    'ACPI_IO_ADDRESS'        => 'acpi::IOAddress',
    'UINT16'                 => 'u16',
    'UINT8'                  => 'u8',
    'UINT32'                 => 'u32',
    'UINT64'                 => 'u64',
    'timespec'               => 'std::time::Duration',
    'paddr_t'                => 'PhysicalAddress',
    'vaddr_t'                => 'VirtualAddress',
    'zx::duration'           => 'zx::Duration',
    'zx::time'               => 'zx::Time',
    'cmd_args'               => 'CmdArgs',
    'uint'                   => 'u32',
    'unsigned long long int' => 'u64',
    'ip6_hdr_t'              => 'Ip6Hdr',
    'arm64_asid_width'       => 'Arm64AsidWidth',
    'async_dispatcher_t'     => 'AsyncDispatcher',
    'zx_status_t'            => 'zx::Status',
    'zx_paddr_t'             => 'zx::PhysicalAddress',
    'zx_vaddr_t'             => 'zx::VirtualAddress',
    'zx_handle_t'            => 'zx::Handle',
    'zxio_t'                 => 'zx::IO',
    'zxio_node_attributes_t' => 'zx::IONodeAttributes',
    'zxio_signals_t'         => 'zx::IOSignals',
    'zx_signals_t'           => 'zx::Signals',
    'zx_iovec_t'             => 'zx::IOVec',
    'zxio_flags_t'           => 'zx::IOFlags',
    'zxio_storage_t'         => 'zx::IOStorage',
    'zx_info_socket_t'       => 'zx::InfoSocket',
    'zx::socket'             => 'zx::Socket',
    'reboot_flags'           => 'RebootFlags',

    #From Caffe2
    'IntArrayRef'                     => '&[i32]',
    'TensorOptions'                   => 'TensorOptions',
    'Args'                            => 'Args',
    'c10::OperatorHandle'             => 'c10::OperatorHandle',
    'torch::jit::Stack'               => 'torch::jit::Stack',
    'kVmapNumLevels'                  => 'kVmapNumLevels',
    'kVmapMaxTensorDims'              => 'kVmapMaxTensorDims',
    'string_view'                     => 'str',
    'uint8_t'                         => 'u8',
    'BFloat16'                        => 'bf16',
    'Half'                            => 'f16',
    'cudnnDataType_t'                 => 'CudnnDataType',
    'cudnnPoolingMode_t'              => 'cudnn::PoolingMode',
    'cudnnPoolingDescriptor_t'        => 'cudnn::PoolingDescriptor',
    'miopenDataType_t'                => 'MIOpenDataType',
    'IntArrayRef'                     => '&[i32]',
    'fp16_t'                          => 'f16',
    'google::protobuf::RepeatedField' => 'protobuf::RepeatedField',
    'google::protobuf::MessageLite'   => 'protobuf::MessageLite',
    'cudaDeviceProp'                  => 'CudaDeviceProp',
    'cublasStatus_t'                  => 'CuBlasStatus',
    'curandStatus_t'                  => 'CuRandStatus',
    'curandGenerator_t'               => 'CuRandGenerator',
    'cudnnStatus_t'                   => 'cudnn::Status',
    'cudnnTensorFormat_t'             => 'cudnn::TensorFormat',
    'cudnnDataType_t'                 => 'cudnn::DataType',
    'cudnnFilterDescriptor_t'         => 'cudnn::FilterDescriptor',
    'cudnnTensorDescriptor_t'         => 'cudnn::TensorDescriptor',
    'cudnnDropoutDescriptor_t'        => 'cudnn::DropoutDescriptor',
    'PerGPUCuDNNStates'               => 'PerGpuCudnnStates',
    'rand_gen_type'                   => 'RandGenType',
    'interrupt_saved_state_t'         => 'InterruptSavedState',
    'cudaStream_t'                    => 'cuda::Stream',
    'cublasHandle_t'                  => 'cublas::Handle',
    'cudnnHandle_t'                   => 'cudnn::Handle',
    'miopenTensorDescriptor_t'        => 'MIOPENTensorDescriptor',
    'miopenActivationDescriptor_t'    => 'MIOPENActivationDescriptor',
    'CuDNNWrapper'                    => 'CuDnnWrapper',
    'cudnnTensorDescriptor_t'         => 'CudnnTensorDescriptor',
    'cudnnActivationDescriptor_t'     => 'CudnnActivationDescriptor',
    'cudnnConvolutionDescriptor_t'    => 'CudnnConvolutionDescriptor',
    'cudnnConvolutionBwdFilterAlgo_t' => 'cudnn::ConvolutionBwdFilterAlgo',
    'cudnnConvolutionBwdDataAlgo_t'   => 'cudnn::ConvolutionBwdDataAlgo',
    'cudnnConvolutionFwdAlgo_t'       => 'cudnn::ConvolutionFwdAlgo',
    'cudnnConvolutionBwdFilterAlgo_t' => 'cudnn::ConvolutionBwdFilterAlgo',

    #TODO
    'vector<int>'                            => 'Vec<i32>',
    'std::mutex'                             => 'parking_lot::RawMutex',
    'zx::status'                             => 'zx::Status',
    'iformat'                                => 'IFormat',
    'idtype'                                 => 'IDType',
    'iscale'                                 => 'IScale',
    'ideep::scale_t'                         => 'IDEEP::Scale',
    'itensor'                                => 'ITensor',
    'itensor::descriptor'                    => 'ITensor::Descriptor',
    'itensor::dims'                          => 'ITensor::Dims',
    't_tuple'                                => '(Tensor, Tensor)',
    'iprop'                                  => 'IProp',
    'itensor'                                => 'ITensor',
    'ialgo'                                  => 'IAlgo',
    'iattr'                                  => 'IAttr',
    'ilowp_kind'                             => 'ILowpKind',
    'ideep::tensor'                          => 'IDEEP::Tensor',
    'ideep::tensor::dims'                    => 'IDEEP::Tensor::Dims',
    'ideep::tensor::descriptor'              => 'IDEEP::Tensor::Descriptor',
    'ideep::convolution_forward_params'      => 'IDEEP::ConvolutionForwardParams',
    'rand_gen_type'                          => 'RandGenType',
    'std::mt19937'                           => 'mt19937::MT19937',
    'std::bernoulli_distribution'            => 'rand::distributions::Bernouilli',
    'cudnnLRNDescriptor_t'                   => 'cudnn::LRNDescriptor',
    'Eigen::Array4f'                         => '[f32; 4]',
    'Eigen::Array4d'                         => '[f64; 4]',
    'Eigen::Array3f'                         => '[f32; 3]',
    'Eigen::Array3d'                         => '[f64; 3]',
    'Eigen::Array2f'                         => '[f32; 2]',
    'Eigen::Array2d'                         => '[f64; 2]',
    'ConstEigenMatrixMap'                    => 'ndarray::ArrayView2',
    'EigenMatrixMap'                         => 'ndarray::ArrayViewMut2',
    'legacy_pthreadpool_function_1d_tiled_t' => 'LegacyPThreadPoolFunction1DTiled',
    'legacy_pthreadpool_t'                   => 'LegacyPThreadPool',
    'legacy_pthreadpool_function_2d_t'       => 'LegacyPThreadPoolFunction2D',
    'legacy_pthreadpool_function_2d_tiled_t' => 'LegacyPThreadPoolFunction2DTiled',
    'legacy_pthreadpool_function_3d_tiled_t' => 'LegacyPThreadPoolFunction3DTiled',
    'legacy_pthreadpool_function_4d_tiled_t' => 'LegacyPThreadPoolFunction4DTiled',
    'qnnp_operator_t'                        => 'QnnpOperator',
);

 our %defaultsmap = 
 %(
     'NULL' => 'None',
     'std::numeric_limits<double>::infinity()' => 'f64::MAX',
     'std::numeric_limits<f32>::infinity()'    => 'f32::MAX',
 );

 our %kwmap = 
 %(
     'box'   => 'box_',
     'in'    => 'input',
     'type'  => 'ty',
 );

