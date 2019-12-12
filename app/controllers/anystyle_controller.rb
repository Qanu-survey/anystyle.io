class AnystyleController < ApplicationController
  attr_reader :parser

  def index
  end

  def parse
    render json: AnyStyle.parse(input, format: 'wapiti').map { |s| s.map { |t| [t.label, t.value] } }
  ensure
    set_last_modified
  end

  private

  def input
    request.params[:input]
  end

  def set_last_modified
    response.headers['X-AnyStyle-Last-Modified'] = mtime(AnyStyle.parser.model)
  end

  def mtime(model)
    view_context.time_ago_in_words File.mtime(model.path), include_seconds: true
  end
end