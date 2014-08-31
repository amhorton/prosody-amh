class Api::AnnotationsController < ApplicationController
  wrap_parameters false

  def create
    puts "in controller action"
    @annotation = current_user.annotations.new(annotation_params)

    if @annotation.save
      render json: @annotation
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