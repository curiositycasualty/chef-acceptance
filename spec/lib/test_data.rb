module TestData
  class Account
    @fullname
    @username
    @password
    @email
    @company
    #@orgs = {} # {[Organization, :admin => true]}
  end

  class Organization

    def fullname=(fullname)
      @fullname = fullname
    end

    def fullname
      @fullname
    end

    def shortname=(shortname)
      @shortname = shortname
    end

    def shortname
      @shortname
    end

    def owner=(username)
      @owner = username
    end

    def owner
      @owner
    end

    #@accounts = {} # { [Account, :admin => true] }
  end

end