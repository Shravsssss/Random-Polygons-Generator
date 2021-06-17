	
	#wkt_polygon Function
	#bbox: lat/long bounding box for the centers of the polygons, numeric vector of the form
	#fmt: number of digits (Default = 7)
	wkt_polygon <- function(count = 1, num_vertices = 10, max_radial_length = 10,
							bbox = NULL, fmt = 7) {
	  assert(fmt, c('numeric', 'integer'))
	  res <- geo_polygon(count, num_vertices, max_radial_length, bbox)
	  unlist(
		lapply(res$features, function(z)to_wkt_poly(z$geometry$coordinates[[1]], fmt))
	  )
	}

	#geo_polygon Function
	#max_radial_length: maximum distance that a vertex can reach out of the center of the polygon
	#bbox: lat/long bounding box for the centers of the polygons, numeric vector of the form
	geo_polygon <- function(count = 1, num_vertices = 10, max_radial_length = 10, bbox = NULL) {
	  assert(count, c('numeric', 'integer'))
	  assert(num_vertices, c('numeric', 'integer'))
	  assert(max_radial_length, c('numeric', 'integer'))
	  assert(bbox, c('numeric', 'integer'))
	  if (!is.null(bbox)) stopifnot(length(bbox) == 4)

	  features <- list()
	  for (i in seq_len(count)) {
		hub <- position(bbox)
		vertices <- list()
		circle_distances <- stats::runif(num_vertices) * max_radial_length
		circle_bearings <- sort(stats::runif(num_vertices) * 2 * pi)
		vertices <- mapply(destination, distance = circle_distances, bearing = circle_bearings,
							MoreArgs = list(origin = hub), SIMPLIFY = FALSE)

		# close the ring
		vertices <- c(vertices, vertices[1])

		features[[i]] <- feature(polygon(vertices))
	  }
	  structure(fc(features), class = "geo_list")
	}
