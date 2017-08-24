if Serve.env["REQUEST_METHOD"] == "POST"
    create_table
    # Serve.redirect("/")
end