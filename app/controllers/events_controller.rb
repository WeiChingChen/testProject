class EventsController < ApplicationController
	
	before_filter :find_event, :only => [:show, :edit, :update, :destroy]
    def index
        #@events = Event.all         #將資料全撈出來
		@events = Event.page( params[:page] ).per(5)  #每頁3筆,只撈3筆資料,show 在第一頁
		
		respond_to do |format|
		    format.html # index.html.erb
			format.json { render :json => @events.to_json }
			format.xml { render :xml => @events.to_xml }
			format.atom		
		end
    end
	
    def show
			respond_to do |format|
		       format.html # show.html.erb
			   format.json { render :json => @events.to_json }
			   format.xml { render :xml => @events.to_xml }
			   format.atom { @feed_title = "My event list" } # index.atom.builder
			end
    end
	
	def new
		@event = Event.new
	end
	
	def create
		@event = Event.new( params[:event] )
		if @event.save
		  flash[:notice] = "新增成功"
          redirect_to :action => :index
        else
          render :action => :new	#用new的template,並不是去執行new這個動作
        end		  
	end
	
	def edit
	end
	
	def update
		@event.update_attributes( params[:event] )
		
		flash[:notice] = "更新成功"		
		redirect_to :action => :index
	end
	def destroy
		@event.destroy
		
		flash[:alert] = "刪除成功"		
		redirect_to :action => :index
	end
	
	protected
	
	def find_event
		@event = Event.find( params[:id] )
	end
end
