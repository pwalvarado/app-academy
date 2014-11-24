json.extract!(list, :title);
json.cards list.cards, partial: 'api/cards/show', as: :card