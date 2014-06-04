{
    'variables': {
        #TODO
    },
    'includes': [
      '../common.gypi',
    ],
    'target_defaults': {
        #TODO
    },
    'targets': [
      {
        'target_name': 'shared_t',
        'type': 'shared_library',
        #'include_dirs': [ # seems include_dirs not needed in shared target
        #    'include',
        #],
        'sources': [
            'src/math.cpp'
        ],
        'direct_dependent_settings': {
            'include_dirs': [
                'include',
            ],
        },
        'conditions': [
            ['OS=="android"', { # android platform
                'link_settings': {
                    'ldflags': [
                        '-llog',
                    ]
                },
            }],
        ]


      },
    ],
}