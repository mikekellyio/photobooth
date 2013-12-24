class EventsController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @events = Event.all.desc(:active, :created_at)
    respond_with @events
  end

  def show
    @event = Event.find(params[:id])
    redirect_to event_photos_url(@event)
  end

  def new
    @event = Event.new name: Date.today.to_s
    respond_with @event
  end

  def create
    @event = Event.create params[:event].permit(:name)
    @event.save

    respond_with @event
  end

  def edit
    @event = Event.find(params[:id])
    respond_with @event
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(params[:event])

    respond_with @event
  end

  def activate
    @event = Event.find(params[:id])
    @event.activate!

    respond_with @event
  end

end
