class StaffsController < ApplicationController
	def index
	end
	def show 
		@staff = Staff.find(params[:id])
	end
	def new
		
	end
	def create
	end
	def update 
	end
	def destroy
	end
	def edit 
	end
	def hello(paras) 
		puts paras
	end
end
