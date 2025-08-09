local lvgl = require("lvgl")
local TextFont = require("utils.text_font")

local M = {}

local function check_winner(board)
  -- Rows, columns, diagonals
  for i = 1, 3 do
    if board[i][1] ~= "" and board[i][1] == board[i][2] and board[i][2] == board[i][3] then
      return board[i][1]
    end
    if board[1][i] ~= "" and board[1][i] == board[2][i] and board[2][i] == board[3][i] then
      return board[1][i]
    end
  end
  if board[1][1] ~= "" and board[1][1] == board[2][2] and board[2][2] == board[3][3] then
    return board[1][1]
  end
  if board[1][3] ~= "" and board[1][3] == board[2][2] and board[2][2] == board[3][1] then
    return board[1][3]
  end
  return nil
end

local function is_full(board)
  for i = 1, 3 do
    for j = 1, 3 do
      if board[i][j] == "" then return false end
    end
  end
  return true
end

function M.create()
  local screen = lvgl.Object()
  screen:set {
    w = 211,
    h = 520,
    pad_all = 0,
    border_width = 0,
    bg_color = "#222222"
  }

  local title = screen:Label {
    text = "Tic Tac Toe",
    text_font = TextFont.get(28),
    text_color = "#ffffff",
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 20 }
  }

  local board = {
    { "", "", "" },
    { "", "", "" },
    { "", "", "" }
  }
  local current = "X"
  local status_label
  local btns = {}
  local labels = {}

  local function update_status(msg)
    status_label:set { text = msg }
  end

  local function reset_board()
    for i = 1, 3 do
      for j = 1, 3 do
        board[i][j] = ""
        if labels[i] and labels[i][j] then
          labels[i][j]:set { text = "" }
        end
      end
    end
    current = "X"
    update_status("Player X's turn")
  end

  -- Board UI
  local board_container = screen:Object {
    w = 200,
    h = 200,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 20 },
    bg_color = "#333333",
    radius = 10,
    border_width = 0,
    pad_all = 1
  }

  for i = 1, 3 do
    btns[i] = {}
    labels[i] = {}
    for j = 1, 3 do
      btns[i][j] = board_container:Object {
        w = 60,
        h = 60,
        x = (j - 1) * 65 + 5,
        y = (i - 1) * 65 + 5,
        bg_color = "#444444",
        radius = 8,
        border_width = 0
      }
      btns[i][j]:add_flag(lvgl.FLAG.CLICKABLE)
      btns[i][j]:clear_flag(lvgl.FLAG.SCROLLABLE)
      local lbl = btns[i][j]:Label {
        text = "",
        text_font = TextFont.get(32),
        text_color = "#ffffff",
        align = { type = lvgl.ALIGN.CENTER }
      }
      labels[i][j] = lbl
      btns[i][j]:onClicked(function()
        if board[i][j] == "" and not check_winner(board) then
          board[i][j] = current
          lbl:set { text = current }
          local winner = check_winner(board)
          if winner then
            update_status("Player " .. winner .. " wins!")
          elseif is_full(board) then
            update_status("Draw!")
          else
            current = (current == "X") and "O" or "X"
            update_status("Player " .. current .. "'s turn")
          end
        end
      end)
    end
  end

  status_label = screen:Label {
    text = "Player X's turn",
    text_font = TextFont.get(20),
    text_color = "#ffffff",
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 70 }
  }

  local reset_btn = screen:Object {
    w = 100,
    h = 40,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 110 },
    bg_color = "#3498DB",
    radius = 8,
    border_width = 0
  }
  reset_btn:add_flag(lvgl.FLAG.CLICKABLE)
  reset_btn:Label {
    text = "Reset",
    text_font = TextFont.get(20),
    text_color = "#ffffff",
    align = { type = lvgl.ALIGN.CENTER }
  }
  reset_btn:onClicked(reset_board)

  -- Back button
  local back_btn = screen:Object {
    w = 200,
    h = 40,
    bg_color = "#202020",
    radius = 10,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 455 }
  }
  back_btn:add_flag(lvgl.FLAG.CLICKABLE)
  back_btn:Label {
    text = "Back",
    text_color = "#FFFFFF",
    text_font = TextFont.get(18),
    align = { type = lvgl.ALIGN.CENTER }
  }
  back_btn:onClicked(function()
    _G.ScreenManager.show_screen("games")
  end)

  return screen
end

return M
