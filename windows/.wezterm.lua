local wezterm = require 'wezterm'
local act = wezterm.action

local function create_font_list(opts)
    local weight = (opts and opts.weight) or 'Regular'
    local italic = (opts and opts.italic) or false
    return wezterm.font_with_fallback {
        { family = 'CommitMono', weight = weight, italic = italic },
        { family = 'Symbols Nerd Font', scale = 0.85, weight = weight, italic = italic },
    }
end

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local function conditional_direction_action(wezterm_action, nvim_keys)
    return wezterm.action_callback(function(window, pane)
        if is_vim(pane) then
            window:perform_action(wezterm.action.SendKey{ key = nvim_keys, mods = 'ALT' }, pane)
        else
            window:perform_action(wezterm.action.ActivatePaneDirection(wezterm_action), pane)
        end
    end)
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
    bold_brightens_ansi_colors = 'No',
    allow_square_glyphs_to_overflow_width = 'Never',
    use_cap_height_to_scale_fallback_fonts = true,
    inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.5,
    },

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
    selection_word_boundary = [[ ,:"'`│·()[]{}<>]],
    quick_select_patterns = { [[https?://[A-Za-z0-9/._~%!$&'()*+,;=:@?-]+]] },

    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 3000 },
    keys = {
        {
            key = 'c',
            mods = 'CTRL|SHIFT',
            action = wezterm.action_callback(function(window, pane)
                window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
                -- The default CTRL+SHIFT+c action doesn't clear selection after copy
                window:perform_action(act.ClearSelection, pane)
            end),
        },
        {
            key = '"',
            mods = 'CTRL|SHIFT|ALT',
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = '%',
            mods = 'CTRL|SHIFT|ALT',
            action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 's',
            mods = 'LEADER',
            action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'v',
            mods = 'LEADER',
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'w',
            mods = 'LEADER',
            action = act.PaneSelect,
        },
        {
            key = 'w',
            mods = 'LEADER|ALT',
            action = act.PaneSelect {
                mode = 'SwapWithActiveKeepFocus',
            },
        },
        {
            key = 'k',
            mods = 'ALT',
            action = conditional_direction_action('Up', 'k'),
        },
        {
            key = 'j',
            mods = 'ALT',
            action = conditional_direction_action('Down', 'j'),
        },
        {
            key = 'h',
            mods = 'ALT',
            action = conditional_direction_action('Left', 'h'),
        },
        {
            key = 'l',
            mods = 'ALT',
            action = conditional_direction_action('Right', 'l'),
        },
        {
            key = 'F12',
            mods = 'CTRL|SHIFT|ALT',
            action = act.ShowDebugOverlay,
        },
    },
}
