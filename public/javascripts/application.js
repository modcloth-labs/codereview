var codereview = {
  initialize: function() {
    //
  },

  accept: function(id_to_accept){
    $('#' + id_to_accept).children().animate(
      { height: 0, opacity: 0, color: '#40ae4c', display: 'hidden' },
      { complete: function() { $(this).parent().remove(); } }
    );
  },

  reject: function(id_to_reject){
    $('#' + id_to_reject).animate(
      { color: '#a54750' },
      { complete: function() { $(this).removeClass('new').addClass('rejected'); } }
    );
  },

  restart: function(id_to_restart){
    $('#' + id_to_restart ).animate(
      { color: '#cdc8b1' },
      { complete: function() { $(this).removeClass('rejected').addClass('restarted'); } }
    );
  },

  start_review: function(id_to_review) {
    $('#' + id_to_review + ' .buttons-container.start-skip-review').hide();
    $('#' + id_to_review + ' .buttons-container.accept-reject-commit').fadeIn(100);
    $('#' + id_to_review).removeClass('new').addClass('in-review');
  },
  
  sampleNamespace: {}
};


codereview.sampleNamespace = { 
  gitVars: {
    repoAddress: {}
  }
};

(function(self) {
  $.extend(self,{
    name: 'Karen',
    initialize: function() {
      setName();
      alert('hello '+ self.name + '!');
    }
  });

  function setName() {
    // alert('test');
    self.name = 'Brian';
    console.log(self);
    // codereview.sampleNamespace.gitVars.repoAddress.name = 'Brian';
  }

})(codereview.sampleNamespace.gitVars.repoAddress)

