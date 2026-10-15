#' get the cod_esp_gen for aphia_id or code_strap
#' @export
get_cod_esp_gen <- function(aphia_id = NULL, code_strap = NULL) {

  if (is.null(aphia_id) && is.null(code_strap)) {
    stop("must provide either aphia_id or code_strap")
  } else if (is.null(aphia_id)) {
    code_type <- "code_strap"
    code <- code_strap
  } else {
    code_type <- "aphia_id"
    code <- aphia_id
  }

  # TODO: sanitize against SQL injection
  query <- paste0("SELECT code as cod_esp_gen FROM ESPECE_GENERAL_NORME WHERE ", code_type, "=", code, ";")
  result <- DBI::dbGetQuery(oracle_conn, query)
  DBI::dbDisconnect(oracle_conn)

  if (length(result) != 1) {
    warning("Cannot obtain unamgiguous cod_esp_gen")
    return(NA)
  }

  cod_esp_gen <- result[1]

  return(cod_esp_gen)

}