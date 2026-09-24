local cwd = vim.fn.getcwd()

local project_file = vim.fs.find('project.godot', {
    upward = true,
    path = cwd,
    type = 'file',
})[1]

if project_file then
    pcall(vim.fn.serverstart, '127.0.0.1:55432')
end
