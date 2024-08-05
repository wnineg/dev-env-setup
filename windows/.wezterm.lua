local wezterm = require 'wezterm'
local act = wezterm.action

local function create_font_list(opts)
    local weight = (opts and opts.weight) or 'Regular'
    local italic = (opts and opts.italic) or false
    return wezterm.font_with_fallback {
        { family = 'CommitMono', weight = weight, italic = italic },
        { family = 'CommitMono Nerd Font', scale = 0.8, italic = italic },
        { family = 'Nerd Font Symbols Font', italic = italic },
    }
end

return {
    wsl_domains = {
        {
            name = 'WSL:Ubuntu',
            distribution = 'Ubuntu',
            default_cwd = '~',
        },
    },
    default_domain = 'WSL:Ubuntu',

    color_scheme = 'Solarized (dark) (terminal.sexy)',

    font_size = 10,
    font = create_font_list(),
    font_rules = {
        {
            intensity = 'Bold',
            italic = false,
            font = create_font_list({ weight = 'Bold' }),
        },
        {
            intensity = 'Bold',
            italic = true,
            font = create_font_list({ weight = 'Bold', italic = true }),
        },
    },
    allow_square_glyphs_to_overflow_width = 'Never',
    use_cap_height_to_scale_fallback_fonts = true,

    --config.cursor_thickness = '3px',
    force_reverse_video_cursor = true,

    alternate_buffer_wheel_scroll_speed = 0,
    mouse_bindings = {
        -- Disables copy on mouse selection
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'NONE',
            action = act.Nop,
        },
    },
    selection_word_boundary = [[ :"'│·]],

    keys = {
        -- The default CTRL+SHIFT+C action doesn't clear selection after copy
        {
            key = 'c',
            mods = 'CTRL|SHIFT',
            action = wezterm.action_callback(function(window, pane)
                window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
                window:perform_action(act.ClearSelection, pane)
            end),
        },
        {
            key = 'F12',
            mods = 'CTRL|SHIFT|ALT',
            action = act.ShowDebugOverlay,
        },
    },
}
