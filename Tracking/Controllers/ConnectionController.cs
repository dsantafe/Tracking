using System;
using System.Web.Mvc;
using Tracking.BL.DTOs;
using Tracking.BL.Services;

namespace Tracking.Controllers
{
    public class ConnectionController : Controller
    {
        private readonly ConnectionService connectionService;

        public ConnectionController()
        {
            this.connectionService = new ConnectionService();
        }

        // GET: Connection
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(ConnectionDTO connectionDTO)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    connectionService.CreateConnection(connectionDTO.Server,
                        connectionDTO.Database,
                        connectionDTO.User,
                        connectionDTO.Password);

                    ViewBag.Message = "The process has been executed successfully";
                    ViewBag.Type = "info";
                }
            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.Message;
                ViewBag.Type = "danger";
            }

            return View(connectionDTO);
        }
    }
}