if Serve.env["REQUEST_METHOD"] == "POST"
    insert
    Serve.redirect("/view?" + Serve.table)
end