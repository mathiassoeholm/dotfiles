vim.g.dashboard_default_executive = 'telescope'


--     .----.   @   @
--    / .-"-.`.  \v/
--    | | '\ \ \_/ )
--  ,-\ `-.' /.'  /
-- '---`----'----'
vim.g.dashboard_custom_header = { 
    '     .----.   @   @',
    '    / .-"-.`.  \\v/',
    "    | | '\\ \\ \\_/ )",
    "  ,-\\ `-.' /.'  /",
    " '---`----'----'"
}

-- disable the indenLine while dashboard is open
vim.g.indentLine_fileTypeExclude = { 'dashboard' }


vim.g.dashboard_custom_footer = {
   "Slow and steady wins the race",
}
