{
    'variables': {
        #TODO
    },

    'targets': [
    {
        'target_name': 'all',
        'type': 'none',
        'dependencies': [
            'main/main.gyp:*',
            'shared_lib/shared.gyp:*',
            'static_lib/static.gyp:*',
        ],
    },
    ], # targets
}