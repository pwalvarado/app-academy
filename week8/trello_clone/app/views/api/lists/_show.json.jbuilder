json.extract!(list, :id, :title);
json.cards list.cards, partial: 'api/cards/show', as: :card