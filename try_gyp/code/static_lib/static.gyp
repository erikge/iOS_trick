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
        'target_name': 'static_t',
        'type': 'static_library',
        'include_dirs': [
            'include',
        ],
        'sources': [
            'src/say.cpp'
        ],
        'direct_dependent_settings': {
            'include_dirs': [
                'include',
            ],
        },

      },
    ],
}