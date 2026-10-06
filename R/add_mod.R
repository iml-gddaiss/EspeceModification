#' Adds a line to the modification log
#'
#' @param cod_type_modif Code identifiant le type de modification apporté à un "Cod_Esp_Gen"
#' @param nom_typ_modif_f Nom français attribué à "Cod_Typ_Modification"
#' @param nom_typ_modif_a Nom anglais attribué à "Cod_Typ_Modification"
#' @param desc_typ_modif_f Descriptif français associé à "Cod_Typ_Modification"
#' @param desc_typ_modif_a Descriptif anglais associé à "Cod_Typ_Modification"
add_mod <- function(
  no_modification = NULL,
  cod_esp_gen = NULL,
  cod_typ_modif = NULL,
  cod_reference = NULL,
  commentaire = NULL
) {

  if (is.null(no_modification)) {
    stop("parameter no_modification cannot be null")
  }

  if (is.null(cod_esp_gen)) {
    stop("parameter cod_esp_gen cannot be null")
  }

  if (is.null(cod_typ_modif)) {
    stop("parameter cod_typ_modif cannot be null")
  }
  date_modification <- Sys.time()

  #   TODO: prevent SQL injection
  statement <- 'INSERT INTO ESPECE_MODIFICATION ("NO_MODIFICATION", "COD_ESP_GEN", "COD_TYP_MODIF", "COD_REFERENCE", "DATE_MODIFICATION", "COMMENTAIRE")'
  statement <- paste0(statement, ' VALUES (')
  statement <- paste0(statement, paste(no_modification, cod_esp_gen, cod_typ_modif, cod_reference, date_modification, commentaire, sep=','), ");"
)

}
