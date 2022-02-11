subset Positive of Int where  * >= 0;

our class FilePos {
    has Positive $.row    is required;
    has Positive $.column is required;
}

our class Span {
    has Str     $.filename is required;
    has FilePos $.begin    is required;
    has FilePos $.end      is required;
}

our enum Visibility <Public Private PubCrate>

our subset Docs of Str;

our class GenericParam {

}

our class WherePredicate {

}

our class FunctionInput {

}

our class FunctionOutput {

}

#`(examples:
{
  "span" : {
    "begin" : [
      133,
      0
    ],
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs",
    "end" : [
      160,
      1
    ]
  },
  "crate_id" : 0,
  "docs" : "| Map a value x that is uniformly distributed in\n| the range [0, 2^64) to a value uniformly\n| distributed in [0, n) by returning the upper 64\n| bits of x * n.\n|\n| See:\n| https://lemire.me/blog/2016/06/27/a-fast-alternative-to-the-modulo-reduction/",
  "visibility" : "public",
  "inner" : {
    "abi" : "\"Rust\"",
    "decl" : {
      "output" : {
        "inner" : "u64",
        "kind" : "primitive"
      },
      "c_variadic" : false,
      "inputs" : [
        [
          "x",
          {
            "kind" : "primitive",
            "inner" : "u64"
          }
        ],
        [
          "n",
          {
            "inner" : "u64",
            "kind" : "primitive"
          }
        ]
      ]
    },
    "header" : [ ],
    "generics" : {
      "params" : [ ],
      "where_predicates" : [ ]
    }
  },
  "deprecation" : null,
  "id" : "0:46",
  "links" : { },
  "kind" : "function",
  "name" : "map_into_range",
  "attrs" : [ ]
}
{
  "kind" : "function",
  "visibility" : "public",
  "attrs" : [ ],
  "crate_id" : 0,
  "deprecation" : null,
  "docs" : "| Get a comma-separated list of known\n| filter type names.\n|",
  "links" : { },
  "span" : {
    "begin" : [
      328,
      0
    ],
    "end" : [
      348,
      1
    ],
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs"
  },
  "inner" : {
    "generics" : {
      "params" : [
        {
          "kind" : {
            "lifetime" : {
              "outlives" : [ ]
            }
          },
          "name" : "'a"
        }
      ],
      "where_predicates" : [ ]
    },
    "decl" : {
      "inputs" : [ ],
      "c_variadic" : false,
      "output" : {
        "kind" : "borrowed_ref",
        "inner" : {
          "type" : {
            "inner" : "str",
            "kind" : "primitive"
          },
          "mutable" : false,
          "lifetime" : "'a"
        }
      }
    },
    "header" : [ ],
    "abi" : "\"Rust\""
  },
  "name" : "list_block_filter_types",
  "id" : "0:58"
}
{
  "crate_id" : 0,
  "id" : "0:55",
  "deprecation" : null,
  "links" : { },
  "name" : "block_filter_type_by_name",
  "inner" : {
    "abi" : "\"Rust\"",
    "header" : [ ],
    "decl" : {
      "inputs" : [
        [
          "name",
          {
            "inner" : {
              "type" : {
                "kind" : "resolved_path",
                "inner" : {
                  "args" : {
                    "angle_bracketed" : {
                      "args" : [ ],
                      "bindings" : [ ]
                    }
                  },
                  "param_names" : [ ],
                  "id" : "5:7590",
                  "name" : "String"
                }
              },
              "lifetime" : null,
              "mutable" : false
            },
            "kind" : "borrowed_ref"
          }
        ],
        [
          "filter_type",
          {
            "kind" : "borrowed_ref",
            "inner" : {
              "mutable" : true,
              "type" : {
                "kind" : "resolved_path",
                "inner" : {
                  "id" : "0:26",
                  "args" : {
                    "angle_bracketed" : {
                      "bindings" : [ ],
                      "args" : [ ]
                    }
                  },
                  "name" : "BlockFilterType",
                  "param_names" : [ ]
                }
              },
              "lifetime" : null
            }
          }
        ]
      ],
      "c_variadic" : false,
      "output" : {
        "inner" : "bool",
        "kind" : "primitive"
      }
    },
    "generics" : {
      "where_predicates" : [ ],
      "params" : [ ]
    }
  },
  "visibility" : "public",
  "docs" : "| Find a filter type by its human-readable\n| name.\n|",
  "kind" : "function",
  "span" : {
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs",
    "begin" : [
      286,
      0
    ],
    "end" : [
      300,
      1
    ]
  },
  "attrs" : [ ]
}
{
  "docs" : "| Get a list of known filter types.\n|",
  "deprecation" : null,
  "kind" : "function",
  "visibility" : "public",
  "span" : {
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs",
    "begin" : [
      306,
      0
    ],
    "end" : [
      321,
      1
    ]
  },
  "name" : "all_block_filter_types",
  "links" : { },
  "attrs" : [ ],
  "id" : "0:56",
  "inner" : {
    "header" : [ ],
    "abi" : "\"Rust\"",
    "decl" : {
      "inputs" : [ ],
      "output" : {
        "kind" : "borrowed_ref",
        "inner" : {
          "lifetime" : "'a",
          "type" : {
            "inner" : {
              "args" : {
                "angle_bracketed" : {
                  "bindings" : [ ],
                  "args" : [
                    {
                      "type" : {
                        "inner" : {
                          "args" : {
                            "angle_bracketed" : {
                              "args" : [ ],
                              "bindings" : [ ]
                            }
                          },
                          "name" : "BlockFilterType",
                          "param_names" : [ ],
                          "id" : "0:26"
                        },
                        "kind" : "resolved_path"
                      }
                    }
                  ]
                }
              },
              "name" : "HashSet",
              "id" : "1:1807",
              "param_names" : [ ]
            },
            "kind" : "resolved_path"
          },
          "mutable" : false
        }
      },
      "c_variadic" : false
    },
    "generics" : {
      "params" : [
        {
          "kind" : {
            "lifetime" : {
              "outlives" : [ ]
            }
          },
          "name" : "'a"
        }
      ],
      "where_predicates" : [ ]
    }
  },
  "crate_id" : 0
}
{
  "name" : "block_filter_type_name",
  "inner" : {
    "decl" : {
      "output" : {
        "inner" : {
          "lifetime" : "'a",
          "mutable" : false,
          "type" : {
            "kind" : "primitive",
            "inner" : "str"
          }
        },
        "kind" : "borrowed_ref"
      },
      "c_variadic" : false,
      "inputs" : [
        [
          "filter_type",
          {
            "kind" : "resolved_path",
            "inner" : {
              "param_names" : [ ],
              "args" : {
                "angle_bracketed" : {
                  "bindings" : [ ],
                  "args" : [ ]
                }
              },
              "name" : "BlockFilterType",
              "id" : "0:26"
            }
          }
        ]
      ]
    },
    "header" : [ ],
    "abi" : "\"Rust\"",
    "generics" : {
      "params" : [
        {
          "name" : "'a",
          "kind" : {
            "lifetime" : {
              "outlives" : [ ]
            }
          }
        }
      ],
      "where_predicates" : [ ]
    }
  },
  "kind" : "function",
  "span" : {
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs",
    "begin" : [
      271,
      0
    ],
    "end" : [
      279,
      1
    ]
  },
  "links" : { },
  "docs" : "| Get the human-readable name for a filter\n| type. Returns empty string for unknown\n| types.\n|",
  "deprecation" : null,
  "visibility" : "public",
  "crate_id" : 0,
  "id" : "0:53",
  "attrs" : [ ]
}
{
  "id" : "0:60",
  "inner" : {
    "generics" : {
      "params" : [ ],
      "where_predicates" : [ ]
    },
    "decl" : {
      "output" : {
        "kind" : "resolved_path",
        "inner" : {
          "param_names" : [ ],
          "id" : "111:26",
          "args" : {
            "angle_bracketed" : {
              "args" : [ ],
              "bindings" : [ ]
            }
          },
          "name" : "gcs_filter::ElementSet"
        }
      },
      "inputs" : [
        [
          "block",
          {
            "kind" : "borrowed_ref",
            "inner" : {
              "mutable" : false,
              "type" : {
                "kind" : "resolved_path",
                "inner" : {
                  "id" : "48:35",
                  "param_names" : [ ],
                  "args" : {
                    "angle_bracketed" : {
                      "bindings" : [ ],
                      "args" : [ ]
                    }
                  },
                  "name" : "Block"
                }
              },
              "lifetime" : null
            }
          }
        ],
        [
          "block_undo",
          {
            "kind" : "borrowed_ref",
            "inner" : {
              "type" : {
                "inner" : {
                  "id" : "25:761",
                  "args" : {
                    "angle_bracketed" : {
                      "bindings" : [ ],
                      "args" : [ ]
                    }
                  },
                  "param_names" : [ ],
                  "name" : "BlockUndo"
                },
                "kind" : "resolved_path"
              },
              "lifetime" : null,
              "mutable" : false
            }
          }
        ]
      ],
      "c_variadic" : false
    },
    "header" : [ ],
    "abi" : "\"Rust\""
  },
  "kind" : "function",
  "docs" : null,
  "name" : "basic_filter_elements",
  "attrs" : [ ],
  "crate_id" : 0,
  "deprecation" : null,
  "links" : { },
  "span" : {
    "end" : [
      376,
      1
    ],
    "filename" : "bitcoin-blockfilter/src/blockfilter.rs",
    "begin" : [
      350,
      0
    ]
  },
  "visibility" : "public"
}
)
our class Function {
    has Visibility      $.visibility is required;
    has Span            $.span is required;
    has Docs            $.docs;
    has GenericParam    @.generics;
    has WherePredicate  @.predicates;
    has FunctionInput   @.inputs;
    has FunctionOutput  $.output;
    has Str             $.name is required;
}

