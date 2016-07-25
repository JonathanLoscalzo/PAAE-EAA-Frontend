class Service
  attr_accessor :url, :someclass

  def possibleError

  end

  def initialize(jssession)
    @url = "http://localhost:8080/web-module/"
    @jssession = jssession
  end

  def find(id, j_session_id)
    response = HTTParty.get url + "/#{id}", cookies: {"JSESSIONID": j_session_id}
    someClass.new (JSON.parse(response.body))
  end

  def save(params, j_session_id)
    options = {
        cookies: {"JSESSIONID": j_session_id},
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

  def all(j_session_id)
    response = HTTParty.get url, cookies: {"JSESSIONID": j_session_id}
    params = JSON.parse(response.body)
    params.map do |elem|
      someClass.new(elem)
    end
  end

  def all()
    response = HTTParty.get url, cookies: {"JSESSIONID": @jssession }
    params = JSON.parse(response.body)
    params.map do |elem|
      someClass.new(elem)
    end
  end

  def destroy(id, j_session_id)
    response = HTTParty.delete url+"/#{id}", cookies: {"JSESSIONID": j_session_id}
  end
end