return function(dap)
    dap.adapters.godot = {
        type = 'server',
        host = '127.0.0.1',
        port = 6006,
    }

    dap.configurations.gdscript = {
        {
            type = 'godot',
            request = 'launch',
            name = 'Launch Godot',
            project = '${workspaceFolder}',
        },
    }
end
