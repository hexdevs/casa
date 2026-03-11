import $ from "jquery";
import DataTable from "datatables.net";
DataTable($);

export function initializeDataTable(selector) {
  if ($(selector).length > 0) {
    $(selector).DataTable({ searching: true, order: [[0, "asc"]] });
  }
}
