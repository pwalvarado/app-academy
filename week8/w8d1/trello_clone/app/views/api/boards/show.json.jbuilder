json.extract!(@board, :id, :title);
json.lists @board.lists, partial: 'api/lists/show', as: :list