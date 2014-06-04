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
        'target_name': 'main',
        'type': 'executable',
        'sources': [
            './main.cpp'
        ],
        'dependencies': [
            '<(DEPTH)/shared_lib/shared.gyp:*',
            '../static_lib/static.gyp:*',
        ],

      },
    ],
}