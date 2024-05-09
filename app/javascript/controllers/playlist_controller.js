import { Controller } from "@hotwired/stimulus"
import Sortable from '@shopify/draggable/Sortable'

export default class extends Controller {
  static targets = ["video"]
  static values = { changesequrl: String }

  connect() {
    this.sortable = new Sortable(this.element, { draggable: '.row', handle: '.drag-handle' })
    this.sortable.on('drag:stopped', this.afterSort.bind(this))
  }

  afterSort() {
    // stimulus automatically has a variable named videoTargets (based on the targets declared)
    // The trick is to take the video_id saved in the data attributes
    const videoIds = this.videoTargets.map((x) => parseInt(x.dataset['playlistVideo']))
    this.changeSequences(videoIds)
  }

  changeSequences(videoIds) {
    const request = new Request(this.changesequrlValue,
      {
        method: 'PUT',
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({video_ids: videoIds}),
      },
    )
    fetch(request).then((response) => {
      if (!response.ok) {
        window.alert("Failed")
      }
    })
  }
}
