class Post < ApplicationRecord
  # Cette ligne permet de corriger l'erreur "undefined method image"
  has_one_attached :image
  
  # Tu peux aussi ajouter une validation pour être sûre qu'il y a du texte
validates :caption, length: { maximum: 500, message: "ne peut pas dépasser 500 caractères" }end