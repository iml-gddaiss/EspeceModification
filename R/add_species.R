#' Adds a species
#'
#' @param cod_esp_gen Code identifiant une espèce
#' @param nom_commun_esp_f Nom commun français associé à "cod_esp_gen"
#' @param nom_commun_esp_a Nom commun anglais associé à "cod_esp_gen"
#' @param nom_scient_esp Nom scientifique latin associé à "cod_esp_gen"
#' @param niveau_ident_taxo_f Niveau taxonomique de l'identification décrite à "nom_scient_esp" en francais
#' @param niveau_ident_taxo_a Niveau taxonomique de l'identification décrite à "nom_scient_esp" en anglais
#' @param controllee Commentaire sur le nom taxonomique (désuet, contesté, Doublon)
#' @export
add_species <- function(
  cod_esp_gen = NULL,
  nom_commun_esp_f = NULL,
  nom_commun_esp_a = NULL,
  nom_scient_esp = NULL,
  niveau_ident_taxo_f = NULL,
  niveau_ident_taxo_a = NULL,
  controllee = NULL,
  cod_reference = NULL
) {

  if (is.null(cod_esp_gen)) {
    stop("parameter cod_esp_gen cannot be null")
  }

  comments <- paste0("Ajout de l'espèce ", nom_scient_esp, " (", ordre, ") ", " et de ses attributs")

  add_mod(
    cod_esp_gen = cod_esp_gen,
    cod_typ_modif = 1, # add is code 1
    cod_reference = cod_reference,
    commentaire = comments
    )
}
