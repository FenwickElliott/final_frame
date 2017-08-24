def view_table
    require 'bloc_record'
    tbl = Serve.env["QUERY_STRING"]
    scm = Serve.db.schema(tbl)
    res = <<-RES
    <table style="width:100%">
        <tr>
    RES
    scm.keys.each {|k| res << "<th>#{k}</th>"}
    res << "</tr>"

    for i in 1..Serve.db.count(tbl)
        res << "<tr style='text-align:center'>\n"
        Serve.db.objectify_row(tbl,i).values.each {|v| res << "<td>#{v}</td>"}
        res << "</tr>\n"
    end
    res
end