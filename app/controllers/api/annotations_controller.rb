class Api::AnnotationsController < ApplicationController
  wrap_parameters false

  def index
    @annotations = Article.find(params[:article_id]).annotations
    render :index
  end

  def show
    @annotation = Annotation.find(params[:id])
    render partial: "annotation", locals: {annotation: @annotation}
  end

  def create
    @annotation = current_user.annotations.new(annotation_params)
    @annotation.article_id = params[:article_id]

    if @annotation.save
      @annotation.article.user.new_notifications += 1
      render partial: "annotation", locals: {annotation: @annotation}
    else
      render json: @annotation.errors.full_messages, status: 422
    end
  end

  def destroy
  end

  private

  def annotation_params
    params.require(:annotation).permit(:start, :end, :text, :image, :article_id)
  end



end