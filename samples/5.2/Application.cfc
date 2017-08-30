component
  output="false"
{
  // Application properties
  this.name = "SampleApp";
  this.sessionManagement = true;
  this.sessionTimeout = createTimeSpan(0,0,30,0);

  // application start
  public boolean function onApplicationStart() {
    return true;
  }

  // application end
  public void function onApplicationEnd( struct appScope ) {}

  // request start
  public boolean function onRequestStart( string targetPage ) {
    return true;
  }

  // session start
  public void function onSessionStart() {}

  // session end
  public void function onSessionEnd( struct sessionScope, struct appScope ) {}

  // missing template
  public boolean function onMissingTemplate( template ) {
    return true;
  }

}
