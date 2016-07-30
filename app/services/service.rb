class Service
  attr_accessor :url, :someclass

  def possibleError

  end

  def initialize(jssession)
    @url = "http://localhost:8080/web-module/"
    @jssession = jssession
  end

  def find(id)
    response = HTTParty.get url + "/#{id}", cookies: {"JSESSIONID": @jssession}
    someClass.new (JSON.parse(response.body))
  end

  def save_fromjson(params, hashOpts)
    options = {
        cookies: {'JSESSIONID': @jssession},
        body: params.as_json(hashOpts).to_json,
        headers: {'Content-Type' => 'application/json'}
    }

    response = HTTParty.post url, options
    unless response.code==201
      response
    end
  end

  def test(params)
    options = {
        cookies: {"JSESSIONID": @jssession},
        body: params.to_json,
        headers: {'Content-Type' => 'application/json'}
    }
    response = HTTParty.post url, options
    unless response.code==201
      elem.errors.add(possibleError, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
    end
  end

  def save(params)
    options = {
        cookies: {"JSESSIONID": @jssession},
        body: params.to_json,
        headers: {'Content-Type' => 'application/json'}
    }

    elem = someClass.new(params)
    if elem.valid?
      response = HTTParty.post url, options
      unless response.code==201
        elem.errors.add(possibleError, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
      end
    end

    elem
  end

  def all()
    response = HTTParty.get url, cookies: {"JSESSIONID": @jssession}
    params = JSON.parse(response.body)
    params.map do |elem|
      someClass.new(elem)
    end
  end

  def destroy(id)
    response = HTTParty.delete url+"/#{id}", cookies: {"JSESSIONID": @jssession}
  end
end