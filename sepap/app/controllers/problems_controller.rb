# -*- encoding : utf-8 -*-
class ProblemsController < ApplicationController
	load_and_authorize_resource
  # GET /problems
  # GET /problems.xml
  def index
    #@problems = Problem.find(:all, :order => "numero")
    @problems = Problem.select('problems.*').order(:numero).page(params[:page]).per(15)
    #Se utiliza kaminari para paginacion con .page
    
    @tab="listaP" 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.xml
  def show
    @problem = Problem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem }
    end
  end
  
  def show_busqueda
  	@problem = Problem.where(:numero => params[:numero])
  	
  	respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem }
    end
  end

  # GET /problems/new
  # GET /problems/new.xml
  def new
    @problem = Problem.new
    @tab = "newP"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.xml
  def create
    @problem = Problem.new(params[:problem])
    @problem.user_id = current_user.id
	
    respond_to do |format|
      if @problem.save
      	`dos2unix -c mac #{@problem.input} #{@problem.input2} #{@problem.input3} #{@problem.output} #{@problem.output2} #{@problem.output3}`
      	`dos2unix #{@problem.input} #{@problem.input2} #{@problem.input3} #{@problem.output} #{@problem.output2} #{@problem.output3}`
        format.html { redirect_to(@problem, :notice => 'El problema fue creado exitosamente.') }
        format.xml  { render :xml => @problem, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.xml
  def update
    @problem = Problem.find(params[:id])
    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to(@problem, :notice => 'El problema fue actualizado exitosamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.xml
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to(problems_url) }
      format.xml  { head :ok }
    end
  end
end
