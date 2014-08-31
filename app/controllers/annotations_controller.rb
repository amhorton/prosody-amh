class AnnotationsController < ApplicationController
  wrap_parameters false

  def create
    @annotation = current_user.annotations.new(annotation_params)

    redirect_to article_url(@annotation.article) if @annotation.save

  end

  def destroy

  end

  private

  def annotation_params
    params.require(:annotation).permit(:start, :end, :text, :image, :article_id)
  end


end