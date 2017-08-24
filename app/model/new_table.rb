def build_form
    n = Serve.env["QUERY_STRING"].to_i
    n = 5 if n == 0
    res = ""
    for i in 1..n do
        res << "<b>Column #{i}:</b>"
        res << <<-CMD
            name: <input type="text" name="col#{i}"> type: <input type="text" name="type#{i}">
        CMD
        res << "<br/>"
    end
    res
end

def create_table
    require 'bloc_record'
    para = Rack::Request.new(Serve.env).params
    scm = {}
    for i in 1..para.length
        if para["col#{i}"] && para["col#{i}"].length > 0
            scm.store( para["col#{i}"].capitalize , para["type#{i}"].upcase )
        end
    end
    begin
        Serve.db.create_table(para["table_name"], scm)
        Serve.set_table=(para["table_name"])
        puts 'table created'
    rescue => e
        puts e
    end
end