/*
 * imgNotes
 * 
 *
 * Copyright (c) 2017 Wayne Mogg
 * Licensed under the MIT license.
 */
;(function($) {
	$.widget("wgm.imgNotes", $.wgm.imgViewer, {
		options: {
			canEdit: false,
			vAll: "middle",
			hAll: "middle",
			onEdit: $.noop,
			onShow: $.noop,
/*
 * Default callback to create a DOM element to indicate a note location
 *	See the examples for more elaborate alternatives.
 */
			onAdd: function() {
				this.options.vAll = "bottom";
				this.options.hAll = "middle";
				var elem = $(document.createElement('div')).addClass("marker").append($('<p class="marker-text">'+(this.notes.length+1)+'</p>'))
																			  .prepend($('<span class="track-marker"></span>')).attr("title","");
				$(elem).tooltip({
					content: function() {
						return $(elem).data("note").note;
					},
					show: false,
					hide: {delay:700},
					position: {
						within: $(this.view),
						collision: "flipfit"
					}
				});
				return elem;
			},
/*
 *	Default callback when the markers are repainted
 */
			onUpdateMarker: function(elem) {
				var $elem = $(elem),
					note = $elem.data("note");
				var pos = this.imgToView(note.x, note.y);
				if (pos) {
					$elem.css({
						left: (pos.x - $elem.data("xOffset")),
						top: (pos.y - $elem.data("yOffset")),
						position: "absolute"
					});
				}
			},
/*
 *	Default callback when the image view is repainted
 */
			onUpdate: function() {
				var self = this;
				$.each(this.notes, function() {
					self.options.onUpdateMarker.call(self, this);
				});
			}
		},

		_create: function() {
//			the note/marker elements
			this.notes = [];
			var self = this;
			this.options.onClick = 	function(ev) {
										if (self.options.canEdit) {
											ev.preventDefault();
											var rpos = self.cursorToImg(ev.pageX, ev.pageY);
											if (rpos) {
												var elem = self.addNote({x: rpos.x, y: rpos.y, note: ""});
												self.options.onEdit.call(self, ev, elem);
											}
										}
									};
			this._super();
		},
		
		_destroy: function() {
			this.clear();
			this._super();
		},
/*
 *	Add a note 
 */
		addNote: function(note) {
			var self = this,
				elem = this.options.onAdd.call(this, note),
				$elem = $(elem);
			$(this.view).append(elem);
			$elem.data("note", note);
			
			switch (this.options.vAll) {
				case "top": $elem.data("yOffset", 0); break;
				case "bottom": $elem.data("yOffset", $elem.height()); break;
				case "middle": $elem.data("yOffset", Math.round($elem.height()/2)); break;
				default: $elem.data("yOffset", 0);
			}
			switch (this.options.hAll) {
				case "left": $elem.data("xOffset", 0); break;
				case "right": $elem.data("xOffset", $elem.width()); break;
				case "middle": $elem.data("xOffset", Math.round($elem.width()/2)); break;
				default: $elem.data("xOffset", 0);
			}
			$elem.click(function(ev) {
				ev.preventDefault();
				if (self.options.canEdit) {
					self.options.onEdit.call(self, ev, elem);
				} else {
					self.options.onShow.call( self, ev, elem);
				}
			});
			$elem.on("remove", function() {
				self._delete(elem);
			});
			this.notes.push(elem);
			this.update();
			return elem;
			
		},
/*
 *	Number of notes
 */
		count: function() {
			return this.notes.length;
		},
/*
 *	Delete a note
 */
		_delete: function(elem) {
			this.noteCount--;
			this.notes = this.notes.filter(function(v) { return v!== elem; });
			$(elem).off();
			$(elem).remove();
			this.update();
		},
/*
 *	Clear all notes
 */
		clear: function() {
			var num = this.notes.length;
			for ( var i = 0; i < num; i++ ){
				var elem = this.notes[i];
				elem.off();
				elem.remove();
			}
			this.notes=[];
		},

/*
 *	Add notes from a javascript array
 */
		import: function(notes) {
			if (this.ready) {
				var self = this;
				$.each(notes, function() {
					self.addNote(this);
				});
			}
		},

/*
 *	Export notes to an array
 */
		export: function() {
			var notes = [];
			$.each(this.notes, function() {
				var note = $(this).data("note");
				notes.push(note);
			});
			return notes;
		}

	});
})(jQuery);
