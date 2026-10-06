#' Adds a species from WoRMS
#'
#'
#' @param cod_esp_gen Code identifiant une espèce
#' @param nom_commun_esp_f Nom commun français associé à "cod_esp_gen"
#' @param aphia_id WoRMS AphiaID
#' @export
add_worms_species <- function(
  cod_esp_gen = NULL,
  nom_commun_esp_f = NULL,
  aphia_id = NULL
) {

  if (is.null(cod_esp_gen)) {
    stop("parameter cod_esp_gen cannot be null")
  }
  if (is.null(aphia_id)) {
    stop("parameter aphia_id cannot be null")
  }

  nom_commun_esp_a <-""
  nom_scient_esp <-""
  niveau_ident_taxo_a <-""
  niveau_ident_taxo_f <-""
  controllee <- ""
  add_species(
    cod_esp_gen = cod_esp_gen,
    nom_commun_esp_f = nom_commun_esp_f,
    nom_commun_esp_a = nom_commun_esp_a,
    nom_scient_esp = nom_scient_esp,
    niveau_ident_taxo_f = niveau_ident_taxo_f,
    niveau_ident_taxo_a = niveau_ident_taxo_a,
    controllee = controllee,
    cod_reference = 101 # for worms
  )
}
