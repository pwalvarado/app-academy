json.extract!(@board, :title);
json.lists @board.lists, partial: 'api/lists/show', as: :list