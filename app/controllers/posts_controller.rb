require "mini_magick"

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit destroy ]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    style = params[:post] || {}
    caption = params[:post][:caption]
    
    if style[:image].present? && caption.present?
      # 1. Ouverture de l'image
      image = MiniMagick::Image.open(style[:image].tempfile.path)
      
      # --- LE CALCUL MAGIQUE POUR L'UNIFORMITÉ ---
      # On force la taille du texte à 10% de la largeur de l'image.
      # Cela règle le problème de différence entre ton Mac et Render.
      font_size = (image.width * 0.10).to_i
      font_size = 30 if font_size < 30 # Sécurité taille minimum
      
      # 2. Préparation des variables
      txt_color = style[:text_color] == 'indigo-500' ? '#6366f1' : (style[:text_color] || 'white')
      bg_mode   = style[:badge_mode] || 'none'
      filter    = style[:filter_type] || 'none'
      bright    = style[:brightness] || "100"
      contrast  = style[:contrast] || "100"
      intensity = style[:intensity].to_i || 100

      # Gestion de la police selon l'environnement
      if File.exist?("/System/Library/Fonts/Supplemental/Arial Bold.ttf")
        font_path = "/System/Library/Fonts/Supplemental/Arial Bold.ttf"
      else
        font_path = "DejaVu-Sans-Bold" 
      end

      # 3. Application des transformations
      image.combine_options do |c|
        c.auto_orient
        
        # Filtres de couleur
        if filter == "grayscale"
          c.colorspace "Gray"
        elsif filter == "sepia"
          c.sepia_tone "#{intensity * 0.8}%"
        elsif filter == "froid"
          c.fill "#001b4c"
          c.colorize "20%"
        elsif filter == "chaud"
          c.fill "#7d4a00"
          c.colorize "20%"
        end

        # Lumière et Contraste
        c.modulate "#{bright},100,100"
        c.sigmoidal_contrast "#{((contrast.to_i - 100) / 10).abs}x50%" if contrast.to_i != 100

        # Texte avec taille proportionnelle
        c.gravity "Center"
        c.font font_path
        c.pointsize font_size.to_s
        
        # Gestion du fond du texte (Badge)
        u_color = "none"
        if bg_mode == 'dark'
          u_color = "rgba(0,0,0,0.6)"
        elsif bg_mode == 'light'
          u_color = "rgba(255,255,255,0.7)"
          txt_color = "black" if style[:text_color] == "white"
        elsif bg_mode == 'blur'
          u_color = "rgba(255,255,255,0.3)"
        end

        c.fill txt_color
        c.undercolor u_color
        c.annotate "0", caption
      end

      # 4. ENVOI DU FICHIER DIRECTEMENT
      send_file image.path, 
                filename: "cliking_#{Time.now.to_i}.png", 
                type: "image/png", 
                disposition: "attachment"
    else
      redirect_to new_post_path, alert: "Image ou texte manquant."
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params_to_save
    params.require(:post).permit(:caption, :image)
  end
end