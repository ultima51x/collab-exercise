import { Controller } from "@hotwired/stimulus"
import Sortable from '@shopify/draggable/Sortable'
import { Modal } from 'bootstrap'

// This is named video_controller but is mostly involved with
// manipulating the playlists a video belongs to
export default class extends Controller {
  static values = { id: Number }

  connect() {
  }

  openPlaylistModal() {
    const elem = this.element.querySelector('.modal')
    const modal = Modal.getOrCreateInstance(elem)
    modal.show()
  }

  toggleFromPlaylist(evt) {
    const videoId = this.idValue
    debugger
    const playlistId = evt.target.value

    let endpoint;
    if (evt.target.checked) {
      endpoint = `/playlists/${playlistId}/add_video` // add to playlist
    } else {
      // disable pla
      endpoint = `/playlists/${playlistId}/remove_video` // remove from playlist
    }

    const request = new Request(endpoint,
      {
        method: 'PUT',
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({video_id: videoId}),
      },
    )
    fetch(request).then((response) => {
      if (!response.ok) {
        window.alert("Failed")
      }
    })
  }
}
