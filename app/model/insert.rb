def build_form
    tbl = Serve.env["QUERY_STRING"]
    scm = Serve.db.schema(tbl)
    
    res = <<-FORM
    <h1> Inserting into #{tbl} </h1>
    <form action="/insert" method="POST">
    FORM
    scm.delete('id')
    scm.keys.each do |k|
        res << <<-CELL
            #{k} <input type="text" name="#{k}">
            <br/>
        CELL
    end
    res << <<-FORM
        <input type="hidden" name="tbl" value="#{tbl}">
        <input type="submit">
        </form>
    FORM
    res
end

def insert
    para = Rack::Request.new(Serve.env).params
    tbl = para.delete("tbl")
    Serve.set_table=(tbl)
    begin
        Serve.db.insert(tbl, para)
        puts 'inserted'
    rescue => e
        puts e
    end
end