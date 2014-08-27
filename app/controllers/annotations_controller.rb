class AnnotationsController < ApplicationController
  
  def create
    @annotation = Annotation.new(annotation_params)
    
    if @annotation.save
    
  end
  
  def destroy
    
  end
  
  private
  
  def annotation_params
    params.require(:annotation).permit(:start, :end, :text, :image)
  end
  
  
end