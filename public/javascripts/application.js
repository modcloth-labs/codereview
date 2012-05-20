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
    $('#' + id_to_reject ).animate({
      color:'#A54750'
    });
  },

  start_review: function(id) {
    $('#' + id + ' .buttons-container.start-skip-review').hide();
    $('#' + id + ' .buttons-container.accept-reject-commit').fadeIn(100);
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

