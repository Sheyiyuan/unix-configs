-- 提示：如果需要了解选项含义，可使用 `:h <选项名>` 命令查看帮助
vim.opt.clipboard = 'unnamedplus' -- 使用系统剪贴板
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- 补全选项配置
vim.opt.mouse = 'a' -- 允许在nvim中使用鼠标

-- 制表符（Tab）相关配置
vim.opt.tabstop = 4 -- 每个TAB键显示的视觉空格数
vim.opt.softtabstop = 4 -- 编辑时TAB键对应的空格数
vim.opt.shiftwidth = 4 -- 自动缩进时插入的空格数
vim.opt.expandtab = true -- 将TAB转换为空格（主要适配Python开发）

-- 界面（UI）相关配置
vim.opt.number = true -- 显示绝对行号
vim.opt.relativenumber = true -- 左侧显示相对行号（当前行仍为绝对行号）
vim.opt.cursorline = true -- 高亮光标所在行
vim.opt.splitbelow = true -- 新建垂直分割窗口时，窗口在下方打开
vim.opt.splitright = true -- 新建水平分割窗口时，窗口在右侧打开
-- vim.opt.termguicolors = true        -- 在终端中启用24位RGB真彩色
vim.opt.showmode = false -- 隐藏模式提示（如 "-- 插入 --"），我们是有经验的用户，不需要该提示

-- 搜索相关配置
vim.opt.incsearch = true -- 输入搜索字符时实时预览匹配结果
vim.opt.hlsearch = false -- 不高亮显示搜索匹配结果
vim.opt.ignorecase = true -- 搜索默认忽略大小写
vim.opt.smartcase = true -- 若搜索内容包含大写字母，则开启大小写敏感

-- 快捷键映射：Ctrl+Shift+C 复制内容到系统剪贴板
-- 可视模式：复制选中的内容
vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', { 
    noremap = true, 
    silent = true, 
    desc = '复制选中内容到系统剪贴板' 
})
-- 普通模式：复制当前整行
vim.api.nvim_set_keymap('n', '<C-S-c>', '"+yy', { 
    noremap = true, 
    silent = true, 
    desc = '复制当前行到系统剪贴板' 
})
