require "mini_magick"

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit destroy ]

  # Affiche la liste des posts (si tu décides d'en garder en base)
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # Affiche l'éditeur (ton formulaire)
  def new
    @post = Post.new
  end

  # Action déclenchée par le bouton "ENREGISTRER"
  def create
    # 1. Récupération des paramètres envoyés par le formulaire
    style = params[:post] || {}
    caption = params[:post][:caption]
    
    if style[:image].present? && caption.present?
      # 2. Ouverture de l'image temporaire via MiniMagick
      image = MiniMagick::Image.open(style[:image].tempfile.path)
      
      # 3. Préparation des variables de style (Filtres, couleurs, etc.)
      txt_color = style[:text_color] == 'indigo-500' ? '#6366f1' : (style[:text_color] || 'white')
      bg_mode   = style[:badge_mode] || 'none'
      filter    = style[:filter_type] || 'none'
      bright    = style[:brightness] || "100"
      contrast  = style[:contrast] || "100"
      intensity = style[:intensity].to_i || 100

      # --- GESTION DE LA POLICE (MAC VS PRODUCTION/RENDER) ---
      if File.exist?("/System/Library/Fonts/Supplemental/Arial Bold.ttf")
        font_path = "/System/Library/Fonts/Supplemental/Arial Bold.ttf" # Ton Mac
      else
        font_path = "DejaVu-Sans-Bold" # Standard sur les serveurs Linux (Render)
      end

      # 4. Application des transformations via ImageMagick
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

        # Luminosité (modulate : brightness, saturation, hue)
        c.modulate "#{bright},100,100"
        
        # Contraste (sigmoidal-contrast : douceur du rendu)
        if contrast.to_i != 100
          c.sigmoidal_contrast "#{((contrast.to_i - 100) / 10).abs}x50%"
        end

        # Configuration du texte
        c.gravity "Center"
        c.font font_path
        c.pointsize "45"
        
        # Définition de la couleur du badge (le fond du texte)
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
        
        # Dessine le texte sur l'image
        c.annotate "0", caption
      end

      # 5. TÉLÉCHARGEMENT DIRECT VERS TON ORDINATEUR
      # Le fichier est envoyé au navigateur et le processus s'arrête là.
      send_file image.path, 
                filename: "cliking_edit_#{Time.now.to_i}.png", 
                type: "image/png", 
                disposition: "attachment"
    else
      # Si l'image ou le texte est manquant, on renvoie vers l'éditeur
      redirect_to new_post_path, alert: "Veuillez choisir une photo et un message."
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other, notice: "Post supprimé."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Paramètres autorisés pour Rails
  def post_params_to_save
    params.require(:post).permit(:caption, :image)
  end
end