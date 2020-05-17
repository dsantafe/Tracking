using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tracking.BL.DTOs;
using Tracking.BL.Services;

namespace Tracking.Controllers
{
    public class AuditEventsController : Controller
    {
        private readonly AuditEventsService auditEventsService;

        public AuditEventsController()
        {
            this.auditEventsService = new AuditEventsService();
        }

        public ActionResult Index(int? id)
        {
            var listAuditEventsGeneral = auditEventsService.GetReleases();

            var listAuditEventsGeneralDTO = listAuditEventsGeneral.Select(x => x.ReleaseName).Distinct().ToList();
            ViewBag.AuditEventsDTO = listAuditEventsGeneralDTO;

            if (id != null)
            {
                var listAuditEventsDetailsDTO = listAuditEventsGeneral.Where(x => x.ReleaseName == listAuditEventsGeneralDTO[id.Value]).ToList();
                ViewBag.AuditEventsDetailsDTO = listAuditEventsDetailsDTO;
            }

            return View();
        }

        public ActionResult History()
        {
            var listAuditEventsDTO = auditEventsService.GetReleasesHistory();

            var listReleasesDTO = listAuditEventsDTO.Select(x => x.ReleaseName).Distinct().ToList();
            ViewBag.Releases = listReleasesDTO;

            return View(listAuditEventsDTO);
        }

        public ActionResult Compare(int? id)
        {
            var listAuditEventsGeneral = auditEventsService.GetReleases();
            var listAuditEventsGeneralDTO = listAuditEventsGeneral.Select(x => x.ReleaseName).Distinct().ToList();

            var releaseName = listAuditEventsGeneralDTO[id.Value];

            var listAuditEventsTmp = auditEventsService.CompareRelease(releaseName);            

            return View(listAuditEventsTmp);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(AuditEventsDTO auditEventsDTO)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var message = auditEventsService.CreateRelease(auditEventsDTO.ReleaseName);
                    ViewBag.Message = message;
                    ViewBag.Type = "success";
                }
            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.Message;
                ViewBag.Type = "error";
            }

            return View(auditEventsDTO);
        }
    }
}