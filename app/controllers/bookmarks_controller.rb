class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @bookmark = Bookmark.find(params[:id])

    @pagetitle = getTitle(@bookmark.url)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.json
  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end


  # POST /bookmarks
  # POST /bookmarks.json
  def create
    #@bookmark = Bookmark.new(params[:bookmark])
    url_tag = params[:bookmark]["url"]
    array = url_tag.split(",")
    if array.length == 1
      print "action search"
        @tag =   Tag.find_by_name(array[0])  

        if @tag == nil
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: '{ "error" : "No tag found!"}'  }
          end 
        else
        @bookmark_tag  = @tag.bookmarks
        print @bookmark_tag
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @bookmark_tag }
        end
        end 
    else
        url = array[0]

        url = validateURL(url)
        print url
        
        check = url.match(/^Error/)
     
        if check != nil
          response = '{ "error" : "'
          response = response.concat(url);
          response = response.concat('"}');
          respond_to do |format|
            format.html { render action: "new" }
            format.json { render json:  response }
          end
        else
            
            array.delete_at(0)
            tag_ids = Array.new
            array.length.times do |i|
                @tag = Tag.find_by_name(array[i]) 
                if(@tag!=nil)
                  print @tag.id
                  tag_ids << @tag.id
                else
                    @tag = Tag.new(:name => array[i])
                    if @tag.save
                      @tag = Tag.find_by_name(array[i])
                      tag_ids << @tag.id
                    end
                end
            end

            print tag_ids

            @bookmark = Bookmark.new(:url => url, :tag_ids => tag_ids)

            respond_to do |format|
                if @bookmark.save
                  format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
                  format.json { render json: @bookmark, status: :created, location: @bookmark }
                else
                  format.html { render action: "new" }
                  format.json { render json: @bookmark.errors, status: :unprocessable_entity }
                end
            end

        end
        
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end


  def search
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end
  end


  require 'net/http'
  require 'uri'

  def getTitle(url)
    getTitleReg = /<title>(.*?)<\/title>/
    protocolReg = /(.*?):/

    pos = @bookmark.url.index("https://");
    if pos != nil
      url = URI.parse(@bookmark.url)
      req = Net::HTTP::Post.new(url.path)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      data = http.request(req).body
    else
      pos = @bookmark.url.index("http://");
      if pos != nil
        data = Net::HTTP.get(URI(@bookmark.url))
      else
        data = "<title>Unsupported Porotcol</title>"
      end
    end


    titleMatch = getTitleReg.match(data)
    if titleMatch == nil
      pagetitle = "unable to fetch title"
    else
      pagetitle = titleMatch[1]
    end

    return pagetitle

  end
 


  def getValidDomain(token)
    regNoWwwDomain = /^([\w]+\.)?[\w]+\.[[a-z]*[A-Z]*]+$/
    regWWWDomain = /^((w|W)(w|W)(w\.|W\.))([\w]+\.)?[\w]+\.[[a-z]*[A-Z]*]+$/
    regmatch = token =~ regWWWDomain
    domain = nil
    if regmatch == 0  
      domain = token
    else
      regmatch = token =~ regNoWwwDomain
      if regmatch == 0
        domain = "www.".concat(token)
      end
    end
    return domain
  end


  def validateURL(url)
    url = url.gsub(/\\+/, "/");
    url = url.gsub(/\/+/, "/");
    urlToken = url.split("/");
    protocol = "http:"
    domain = nil


    regProtocol = /[[a-z]*[A-Z]*]+:$/
    regLast = /^[\w]+(\.[\w]+)?/

    pos = 0
    if urlToken[0].last == ":"
      #validate protocol
      regmatch = urlToken[0] =~ regProtocol
      if regmatch == 0  
        protocol = urlToken[0]
      end

      domain = getValidDomain(urlToken[1])
      #raise Error, 'Improper domain' if domain == nil
      pos = 2
    else 
      domain = getValidDomain(urlToken[0])
      #raise Error, 'Improper domain' if domain == nil
      pos = 1
    end    

    if domain == nil
      return "Error: Domain invalid"
    end


    cleanURL = protocol.concat("//")
    cleanURL = protocol.concat(domain)

    pathDepth = urlToken.length-(pos+1)
   

    if pathDepth >= 0
      pathDepth.times do |i|
        regmatch = urlToken[i+pos] =~ /[\w]+/
        if regmatch != 0  
          return "Error: path invalid"
        end
        cleanURL = cleanURL.concat("/")
        cleanURL = cleanURL.concat(urlToken[i+pos])
      end

      regmatch = urlToken.last =~ regLast
      if regmatch != 0  
        return "Error: filename invalid"
      end

      cleanURL = cleanURL.concat("/")
      cleanURL = cleanURL.concat(urlToken.last)
    end
    print cleanURL
    #return "Error: "
    return cleanURL

  end



end
