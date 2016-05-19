var AssignSheet = React.createClass ({
  getInitialState: function (){
    return {
      postText: '',
      divClass: "hide",
      secondHidden: "hide"
    };
  },

  handleClick: function (){
    if (this.state.divClass === "hide") {
      this.setState({divClass: ""});
    }else {
      this.setState({divClass: "hide"});
    }
  },

  handleClick2: function (){
    if (this.state.secondHidden === "hide") {
      this.setState({secondHidden: ""});
    }else {
      this.setState({secondHidden: "hide"});
    }
  },

  handleChange: function (event) {
      this.setState({
        postText: event.target.value
    });
  },

  handleDown: function (event) {
    if (event.keyCode === 13) {
      this.handlePost();
    }
  },

  handlePost: function () {
    that = this;
    $.ajax({
      method: "POST",
      url: "/sheet_templates/",
      data: {
        sheet_template: {
          game_name: this.state.postText,
          game_id: this.props.gameId
        }
      },
      success: function(response) {
        window.location.replace("/sheet_templates/" + response.redirect_id + "/?game=" + that.props.gameId);
      }
    })
  },

  render: function () {
    return (
    <div>
      <p onClick={this.handleClick} className="click-me" id="template-create"><strong>Do you want to create your own sheet for this game?</strong></p>
      <div className={this.state.divClass}>
        <input className="center"
          placeholder="Name the Sheet Template"
          value={this.state.postText}
          onKeyDown={this.handleDown}
          onChange={this.handleChange}/>
          <h6 className="center">Press enter to create a sheet</h6>
      </div>
      <p onClick={this.handleClick2} className="click-me" id="template-search"><strong>Do you want to use a sheet that already exists?</strong></p>
      <div className={this.state.secondHidden}>
        <TemplateSearch
          gameId={this.props.gameId}
        />
      </div>
    </div>
    );
  }
});
