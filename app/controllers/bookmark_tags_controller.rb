class BookmarkTagsController < ApplicationController
  # GET /bookmark_tags
  # GET /bookmark_tags.json
  def index
    @bookmark_tags = BookmarkTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmark_tags }
    end
  end

  # GET /bookmark_tags/1
  # GET /bookmark_tags/1.json
  def show
   # @bookmark_tag = BookmarkTag.find(params[:id])

     @tag =   Tag.find_by_name(params[:id])    
     @bookmark_tag  = @tag.bookmarks
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark_tag }
    end
  end

  # GET /bookmark_tags/new
  # GET /bookmark_tags/new.json
  def new
    @bookmark_tag = BookmarkTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark_tag }
    end
  end

  # GET /bookmark_tags/1/edit
  def edit
    @bookmark_tag = BookmarkTag.find(params[:id])
  end

  # POST /bookmark_tags
  # POST /bookmark_tags.json
  def create
    @bookmark_tag = BookmarkTag.new(params[:bookmark_tag])

    respond_to do |format|
      if @bookmark_tag.save
        format.html { redirect_to @bookmark_tag, notice: 'Bookmark tag was successfully created.' }
        format.json { render json: @bookmark_tag, status: :created, location: @bookmark_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmark_tags/1
  # PUT /bookmark_tags/1.json
  def update
    @bookmark_tag = BookmarkTag.find(params[:id])

    respond_to do |format|
      if @bookmark_tag.update_attributes(params[:bookmark_tag])
        format.html { redirect_to @bookmark_tag, notice: 'Bookmark tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmark_tags/1
  # DELETE /bookmark_tags/1.json
  def destroy
    @bookmark_tag = BookmarkTag.find(params[:id])
    @bookmark_tag.destroy

    respond_to do |format|
      format.html { redirect_to bookmark_tags_url }
      format.json { head :no_content }
    end
  end
end
