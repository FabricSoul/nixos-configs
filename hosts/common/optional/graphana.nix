{...}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "0.0.0.0";
        # and Port
        http_port = 9000;
        # Grafana needs to know on which domain and URL it's running
        domain = "home.anyfq.com";
        root_url = "http://home.anyfq.com:9000/grafana/"; # Not needed if it is `https://your.domain/`
        serve_from_sub_path = true;
      };
    };
  };
}
